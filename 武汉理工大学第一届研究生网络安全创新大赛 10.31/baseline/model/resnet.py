import torch
import torch.nn as nn


class SELayer(nn.Module):
    def __init__(self, channel, reduction=8):
        super(SELayer, self).__init__()
        self.avg_pool = nn.AdaptiveAvgPool2d(1)
        self.fc = nn.Sequential(
            nn.Linear(channel, channel // reduction, bias=False),
            nn.ReLU(inplace=True),
            nn.Linear(channel // reduction, channel, bias=False),
            nn.Sigmoid()
        )

    def forward(self, x):
        b, c, _, _ = x.size()
        y = self.avg_pool(x).view(b, c)
        y = self.fc(y).view(b, c, 1, 1)
        return x * y.expand_as(x)


# SENet 的基础块 SEBasicBlock
# SEBasicBlock是对标准BasicBlock的改进，通过引入SENet中的SE模块对特征进行重新加权，有助于提高模型的性能。
class SEBasicBlock(nn.Module):
    expansion = 1

    def __init__(self, ConvLayer, NormLayer, in_planes, planes, stride=1,reduction=8):
        super(SEBasicBlock, self).__init__()
        self.conv1 = ConvLayer(in_planes, planes, kernel_size=3, stride=stride, padding=1, bias=False)
        self.bn1 = NormLayer(planes)
        self.conv2 = ConvLayer(planes, planes, kernel_size=3, stride=1, padding=1, bias=False)
        self.bn2 = NormLayer(planes)
        self.relu = nn.ReLU(inplace=True)
        self.se = SELayer(planes, reduction)
        
        self.downsample = nn.Sequential()
        if stride != 1 or in_planes != self.expansion*planes:
            self.downsample = nn.Sequential(
                ConvLayer(in_planes, self.expansion*planes, kernel_size=1, stride=stride, bias=False),
                NormLayer(self.expansion*planes)
            )

    def forward(self, x):
        out = self.relu(self.bn1(self.conv1(x)))
        out = self.bn2(self.conv2(out))
        out = self.se(out)
        out += self.downsample(x)
        out = self.relu(out)
        return out    

# ResNet 的基础块 BasicBlock
class BasicBlock(nn.Module):
    expansion = 1

    def __init__(self, ConvLayer, NormLayer, in_planes, planes, stride=1):
        super(BasicBlock, self).__init__()
        self.conv1 = ConvLayer(in_planes, planes, kernel_size=3, stride=stride, padding=1, bias=False)
        self.bn1 = NormLayer(planes)
        self.conv2 = ConvLayer(planes, planes, kernel_size=3, stride=1, padding=1, bias=False)
        self.bn2 = NormLayer(planes)
        self.relu = nn.ReLU(inplace=True)
        
        self.downsample = nn.Sequential()
        if stride != 1 or in_planes != self.expansion*planes:
            self.downsample = nn.Sequential(
                ConvLayer(in_planes, self.expansion*planes, kernel_size=1, stride=stride, bias=False),
                NormLayer(self.expansion*planes)
            )

    def forward(self, x):
        out = self.relu(self.bn1(self.conv1(x)))
        out = self.bn2(self.conv2(out))
        out += self.downsample(x)
        out = self.relu(out)
        return out

# ResNet 是由四个基础块组成的，SENet 中的基础块在 BasicBlock 的基础上增加了 Squeeze-and-Excitation 操作。
class ResNet(nn.Module):
    def __init__(self, in_planes, block, num_blocks, num_classes=10, in_ch=1, feat_dim='2d', **kwargs):
        super(ResNet, self).__init__()
        if feat_dim=='1d':
            self.NormLayer = nn.BatchNorm1d
            self.ConvLayer = nn.Conv1d
        elif feat_dim=='2d':
            self.NormLayer = nn.BatchNorm2d
            self.ConvLayer = nn.Conv2d
        elif feat_dim=='3d':
            self.NormLayer = nn.BatchNorm3d
            self.ConvLayer = nn.Conv3d
        else:
            print('error')

        self.in_planes = in_planes

        self.conv1 = self.ConvLayer(in_ch, in_planes, kernel_size=3, stride=1, padding=1, bias=False)
        self.bn1 = self.NormLayer(in_planes)
        self.relu = nn.ReLU(inplace=True)
        self.layer1 = self._make_layer(block, in_planes, num_blocks[0], stride=1)
        self.layer2 = self._make_layer(block, in_planes*2, num_blocks[1], stride=2)
        self.layer3 = self._make_layer(block, in_planes*4, num_blocks[2], stride=2)
        self.layer4 = self._make_layer(block, in_planes*8, num_blocks[3], stride=2)

    def _make_layer(self, block, planes, num_blocks, stride):
        strides = [stride] + [1]*(num_blocks-1)
        layers = []
        for stride in strides:
            layers.append(block(self.ConvLayer, self.NormLayer, self.in_planes, planes, stride))
            self.in_planes = planes * block.expansion
        return nn.Sequential(*layers)

    def forward(self, x):
        x = self.relu(self.bn1(self.conv1(x)))
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)
        return x

# 统计池化操作，将每个通道的平均值和标准差拼接成一个特征向量
class StatsPool(nn.Module):
    
    def __init__(self):
        super(StatsPool, self).__init__()

    def forward(self, x):
        x = x.view(x.shape[0], x.shape[1], -1)
        out = torch.cat([x.mean(dim=2), x.std(dim=2)], dim=1)
        return out
    
class StatsPool_v2(nn.Module):
    def __init__(self):
        super(StatsPool, self).__init__()

    def forward(self, x):
        x = x.view(x.shape[0], x.shape[1]*x.shape[2], -1)
        out = torch.cat([x.mean(dim=2), x.std(dim=2)], dim=1)
        return out

class ResNet34StatsPool(nn.Module):
    def __init__(self, in_planes, embedding_size, dropout=0.5, **kwargs):

        super(ResNet34StatsPool, self).__init__()
        self.front = ResNet(in_planes, BasicBlock, [3,4,6,3], **kwargs)
        self.pool = StatsPool()
        self.bottleneck = nn.Linear(in_planes*8*2, embedding_size)
        self.drop = nn.Dropout(dropout) if dropout else None
        
    def forward(self, x):
        x = self.front(x.unsqueeze(dim=1))
        x = self.pool(x)
        x = self.bottleneck(x)
        if self.drop:
            x = self.drop(x)
        return x


# 模型2  SEResNet34StatsPool
class SEResNet34StatsPool(nn.Module):
    def __init__(self, in_planes, embedding_size, dropout=0.5, **kwargs):
        super(SEResNet34StatsPool, self).__init__()
        self.front =  ResNet(in_planes, SEBasicBlock, [3,4,6,3], **kwargs)
        self.pool = StatsPool()
        self.bottleneck = nn.Linear(in_planes*8*2*5, embedding_size)
        self.drop = nn.Dropout(dropout) if dropout else None
    # ResNet：经典的深度卷积神经网络模型，用于图像分类任务。
    # SEBasicBlock：ResNet 中的基本块，用于实现深度网络的可训练性。
    # StatsPool：计算特征图的平均值和标准差。
    # Linear：全连接层，用于特征转换。
    # Dropout：随机失活层，用于模型的正则化。
        
    def forward(self, x):
        x=x.unsqueeze(dim=1)
        x = self.front(x)
        x = self.pool(x)
        x = self.bottleneck(x)
        if self.drop:
            x = self.drop(x)
        return x 