# ResNet34StatsPool模型配置文件

class Config(object):
    save_dir = 'Himia_80FBANK_ResNet34StatsPool_AMsoftmax_256'
    train_dir = '/root/master/data/himia/train/SPEECHDATA'
    val_dir = '/root/master/data/himia/test/SPEECHDATA'
    
    workers = 10            #数据装载时cpu所使用的线程数
    batch_size = 128        #一次训练所抓取的数据样本数量；
    max_frames = 200        #每个音频样本中所保留的最大帧数。
    
    data_wavaug = True      #数据增强的类型
    data_specaug = False    #数据增强
    # 在频谱上应用的掩模大小，用于对音频数据进行变形增强。
    specaug_masktime = [10,20]
    specaug_maskfreq = [5,10]
    
    noise_dir = './data/musan'  #噪声数据和房间脉冲响应的路径
    rir_dir = './data/RIRS_NOISES'
    # 频率和时域参数
    fs = 16000          #采样频率
    nfft = 512          #快速傅里叶变换
    win_len = 0.025
    hop_len = 0.01
    n_mels = 80

    # 神经网络的卷积类型（1D或2D）
    conv_type = '2D' #1D, 2D
    # 神经网络的模型类型，输入平面数，嵌入维数和分类器类型。
    model = 'ResNet34StatsPool' # ResNet34StatsPool,TDNN,ECAPA_TDNN
    in_planes = 32 # conv_type:1D, in_planes=n_mels; 2D, in_planes=32, 64
    embd_dim = 256
    hidden_dim = 1024
    classifier = 'AAMSoftmax' # AAMSoftmax,AMSoftmax, ASoftmax, Softmax
    # 角度的margin和scale值。
    angular_m = 0.2
    angular_s = 32

    # 训练的热身周期数和学习率
    warm_up_epoch = 2
    lr = 0.001

    # 训练的周期数和起始周期
    epochs = 40
    start_epoch = 0
    # 是否从上次的训练中加载分类器
    load_classifier = False
    
    seed = 3007
    # 使用的GPU的ID。
    gpu = '0'

    # 由于原始数据格式是kaldi中的数据，这里将其转换成了Python中的字典。
    utt2wav = [line.split() for line in open('%s/wav.scp' % train_dir)]
    spk2int = {line.split()[0]:i for i, line in enumerate(open('%s/spk2utt' % train_dir))}
    spk2utt = {line.split()[0]:line.split()[1:] for line in open('%s/spk2utt' % train_dir)}
    # 验证集
    utt2wav_val = [line.split() for line in open('%s/wav.scp' % val_dir)]

    # 噪音列表
    noise_list = {'noise': [i.strip('\n') for i in open('%s/noise_wav_list'% noise_dir) ],
              'music': [i.strip('\n') for i in open('%s/music_wav_list'% noise_dir) ],
              'reverb': [i.strip('\n') for i in open('%s/rir_list'% rir_dir) ]}
