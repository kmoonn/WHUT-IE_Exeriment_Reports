% 读取标记后的语音文件（你可以使用之前的endpointMarkedSignalEnergy或endpointMarkedSignalZeroCrossing）
[y, fs] = audioread('recorded_audio.wav');

% 设置分帧参数
frameSize = 256; % 帧大小
frameOverlap = 128; % 帧重叠大小

% 分帧处理
frames = buffer(y, frameSize, frameOverlap, 'nodelay');

% 初始化一个矩阵以存储每帧的频谱
spectrogramMatrix = zeros(frameSize, size(frames, 2));

% 计算每帧的频谱
for i = 1:size(frames, 2)
    frame = frames(:, i);
    % 应用FFT
    frameFFT = fft(frame, frameSize);
    % 存储到矩阵中
    spectrogramMatrix(:, i) = abs(frameFFT);
end

% 绘制频谱图
timeFrames = (0:size(frames, 2) - 1) * frameSize / fs;
frequencies = (0:frameSize-1) * fs / frameSize;

figure;
imagesc(timeFrames, frequencies, 10 * log10(spectrogramMatrix));
axis xy;
title('信号频谱');
xlabel('时间 (秒)');
ylabel('频率 (Hz)');
colorbar;
