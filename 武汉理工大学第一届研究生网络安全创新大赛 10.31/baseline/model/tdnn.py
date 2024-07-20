import torch
import torch.nn.functional as F
from torch import nn

# 统计池化层，对输入的特征图在最后一个维度上进行均值和标准差的计算，将结果沿着第二个维度进行拼接，得到一个新的特征向量。
class StatsPool(nn.Module):
    def __init__(self):
        super(StatsPool, self).__init__()

    def forward(self, x):
        x = x.view(x.shape[0], x.shape[1], -1) # [batch_size, 1500, T]
        mean = x.mean(dim=2) # [batch_size, 1500]
        std = x.std(dim=2) # [batch_size, 1500] 
        out = torch.cat([mean, std], dim=1) # [batch_size, 3000]
        return out

# 时间卷积神经网络，用于对语音信号进行特征提取。由一维卷积和批归一化组成。
class TDNN(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size=1, stride=1, padding=0, dilation=1, bias=False):
        super(TDNN,self).__init__()
        self.conv = nn.Conv1d(in_channels, out_channels, kernel_size, stride, padding, dilation, bias=bias)
        self.bn = nn.BatchNorm1d(out_channels)

    def forward(self, x):
        return self.bn(F.relu(self.conv(x)))

# 注意力统计池化，用于对语音信号进行特征提取。由一维卷积、ReLU激活、批归一化、一维卷积和Softmax归一化组成。
class ASP(nn.Module):
    def __init__(self, input_dim=1500, bottleneck_dim=128):
        super(ASP,self).__init__()
        self.attention = nn.Sequential(
            nn.Conv1d(input_dim, bottleneck_dim, kernel_size=1),
            nn.ReLU(),
            nn.BatchNorm1d(bottleneck_dim),
            nn.Conv1d(bottleneck_dim, input_dim, kernel_size=1),
            nn.Softmax(dim=2),
            )
    def forward(self,x):
        w=self.attention(x)
        mu = torch.sum(x * w, dim=2)
        sg = torch.sqrt( ( torch.sum((x**2) * w, dim=2) - mu**2 ).clamp(min=1e-5) )
        x = torch.cat((mu,sg),1)

        x = x.view(x.size()[0], -1)
        return x
        
# 用TDNN和统计池化层搭建的语音信号特征提取模型。
class X_vector(nn.Module):
    def __init__(self, in_dim=24, hidden_dim=512, embedding_size=512):
        super().__init__()
        self.layer1 = TDNN(in_dim, hidden_dim, kernel_size=5, dilation=1)
        self.layer2 = TDNN(hidden_dim, hidden_dim, kernel_size=3, dilation=2)
        self.layer3 = TDNN(hidden_dim, hidden_dim, kernel_size=3, dilation=3)
        self.layer4 = TDNN(hidden_dim, hidden_dim, kernel_size=1, dilation=1)
        self.layer5 = TDNN(hidden_dim, 1500, kernel_size=1, dilation=1)
        self.pooling = StatsPool()
        self.fc1 = nn.Linear(3000, embedding_size)
        self.fc2 = nn.Linear(embedding_size, embedding_size)

    def forward(self, x, bottleneck_last=False):
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)
        x = self.layer5(x)
        x = self.pooling(x)
        embd_a = self.fc1(x)
        embd_b = self.fc2(embd_a)
        if bottleneck_last:  
            return embd_b
        else:
            return embd_a

# 模型 1 X_vector_ASP
# 用ASP和统计池化层搭建的语音信号特征提取模型，比X_vector多了一个注意力机制。
class X_vector_ASP(nn.Module):
    def __init__(self, in_dim=24, hidden_dim=512, embedding_size=512):
        super().__init__()
        self.layer1 = TDNN(in_dim, hidden_dim, kernel_size=5, dilation=1)
        self.layer2 = TDNN(hidden_dim, hidden_dim, kernel_size=3, dilation=2)
        self.layer3 = TDNN(hidden_dim, hidden_dim, kernel_size=3, dilation=3)
        self.layer4 = TDNN(hidden_dim, hidden_dim, kernel_size=1, dilation=1)
        self.layer5 = TDNN(hidden_dim, 1500, kernel_size=1, dilation=1)
        self.pooling = ASP()
        self.fc1 = nn.Linear(3000, embedding_size)
        self.fc2 = nn.Linear(embedding_size, embedding_size)

    def forward(self, x, bottleneck_last=False):
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)
        x = self.layer5(x)
        x = self.pooling(x)
        embd_a = self.fc1(x)
        embd_b = self.fc2(embd_a)
        if bottleneck_last:  
            return embd_b
        else:
            return embd_a
    