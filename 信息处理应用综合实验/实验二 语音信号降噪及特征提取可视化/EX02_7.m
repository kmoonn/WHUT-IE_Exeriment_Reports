% 读取标记后的语音文件（你可以使用之前的endpointMarkedSignalEnergy或endpointMarkedSignalZeroCrossing）
[y, fs] = audioread('recorded_audio.wav');

% 设置分帧参数
frameSize = 256; % 帧大小
frameOverlap = 128; % 帧重叠大小

% 分帧处理
frames = buffer(y, frameSize, frameOverlap, 'nodelay');

% 初始化一个矩阵以存储每帧的Mel滤波后的频谱
melSpectrogram = zeros(frameSize/2 + 1, size(frames, 2));

% 设置Mel滤波器组的参数
numFilters = 26; % Mel滤波器的数量
minFrequency = 0; % 最低频率
maxFrequency = fs / 2; % 最高频率

% 生成Mel滤波器组
melFilters = melFilterBank(numFilters, frameSize, fs, minFrequency, maxFrequency);

% 计算每帧的Mel滤波后的频谱
for i = 1:size(frames, 2)
    frame = frames(:, i);
    
    % 计算每个滤波器的能量
    frameFFT = abs(fft(frame, frameSize));
    filterEnergies = melFilters * (frameFFT(1:frameSize/2 + 1).^2);
    
    % 存储到矩阵中
    melSpectrogram(:, i) = filterEnergies;
end

% 绘制Mel滤波后的频谱图
timeFrames = (0:size(frames, 2) - 1) * frameSize / fs;
frequencies = (0:frameSize/2) * fs / frameSize;

figure;
imagesc(timeFrames, frequencies, 10 * log10(melSpectrogram));
axis xy;
title('Mel滤波后的频谱');
xlabel('时间 (秒)');
ylabel('频率 (Hz)');
colorbar;
