% 读取标记后的语音文件（你可以使用之前的endpointMarkedSignalEnergy或endpointMarkedSignalZeroCrossing）
[y, fs] = audioread('recorded_audio.wav');

% 设置分帧参数
frameSize = 256; % 帧大小
frameOverlap = 128; % 帧重叠大小

% 分帧处理
frames = buffer(y, frameSize, frameOverlap, 'nodelay');

% 创建汉明窗
hammingWindow = hamming(frameSize);

% 应用窗函数到每一帧
framedSignal = bsxfun(@times, frames, hammingWindow);

% 初始化一个空的信号用于存储分帧后的信号
reconstructedSignal = zeros(size(y));

% 逐帧叠加分帧信号
for i = 1:size(frames, 2)
    startIdx = (i - 1) * frameOverlap + 1;
    endIdx = startIdx + frameSize - 1;
    reconstructedSignal(startIdx:endIdx) = reconstructedSignal(startIdx:endIdx) + framedSignal(:, i);
end

% 绘制分帧前后的信号
time = (0:length(y) - 1) / fs;
timeFrames = (0:size(frames, 2) - 1) * frameSize / fs;

subplot(2, 1, 1);
plot(time, y);
title('原始语音信号');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(2, 1, 2);
plot(timeFrames, reconstructedSignal(1:length(timeFrames)));
title('分帧后的语音信号');
xlabel('时间 (秒)');
ylabel('幅度');
