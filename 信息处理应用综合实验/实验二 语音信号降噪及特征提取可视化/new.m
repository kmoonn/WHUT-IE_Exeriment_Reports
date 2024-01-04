% 读取音频文件
[x, Fs] = audioread('hushan.wav'); % 替换为你的音频文件路径

% 参数设置
frameSize = 0.5; % 帧长，单位秒
frameShift = 0.01; % 帧移，单位秒

% 将时间参数转换为样本数
frameLength = 200;
frameStep = 100;

% 分帧
numFrames = floor((length(x) - frameLength) / frameStep) + 1;
frames = zeros(frameLength, numFrames);

for i = 1:numFrames
    startIdx = (i - 1) * frameStep + 1;
    endIdx = startIdx + frameLength - 1;
    frames(:, i) = x(startIdx:endIdx);
end

% 显示分帧后的语音信号
figure;
subplot(2,1,1);
plot(x);
title('原始语音信号');
xlabel('样本数');
ylabel('幅度');

subplot(2,1,2);
imagesc(frames);
title('分帧后的语音信号');
xlabel('帧数');
ylabel('样本数');
