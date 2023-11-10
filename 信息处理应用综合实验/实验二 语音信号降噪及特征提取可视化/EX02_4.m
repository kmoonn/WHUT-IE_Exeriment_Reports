% 读取降噪后的语音文件（你也可以使用之前的estimatedSignal）
[y, fs] = audioread('recorded_audio.wav');

% 设置端点检测参数
frameSize = 256; % 帧大小
frameOverlap = 128; % 帧重叠大小
energyThreshold = 0.01; % 短时能量阈值
zeroCrossingThreshold = 10; % 过零点阈值

% 计算短时能量
energy = sum(buffer(y.^2, frameSize, frameOverlap));

% 计算过零点率
frameDiff = diff(sign(buffer(y, frameSize, frameOverlap)));
zeroCrossings = sum(abs(frameDiff));

% 使用短时能量进行端点检测
energySpeech = find(energy > energyThreshold);
startEnergy = energySpeech(1);
endEnergy = energySpeech(end);

% 使用过零点率进行端点检测
zeroCrossingsSpeech = find(zeroCrossings > zeroCrossingThreshold);
startZeroCrossing = zeroCrossingsSpeech(1);
endZeroCrossing = zeroCrossingsSpeech(end);

% 绘制短时能量和过零点率
time = (0:length(y) - 1) / fs;
subplot(2, 1, 1);
plot(time, y);
title('语音信号');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(2, 1, 2);
timeFrames = (0:length(energy) - 1) * frameSize / fs;
plot(timeFrames, energy, 'r', timeFrames, zeroCrossings, 'g');
title('短时能量和过零点率');
xlabel('时间 (秒)');
ylabel('能量/过零点率');

% 标记端点
figure;
subplot(2, 1, 1);
plot(time, y);
title('语音信号');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(2, 1, 2);
plot(timeFrames, energy, 'r', timeFrames, zeroCrossings, 'g');
title('短时能量和过零点率');
xlabel('时间 (秒)');
ylabel('能量/过零点率');

% 标记端点
endpointMarkedSignalEnergy = zeros(size(y));
endpointMarkedSignalEnergy(startEnergy:endEnergy) = y(startEnergy:endEnergy);

endpointMarkedSignalZeroCrossing = zeros(size(y));
endpointMarkedSignalZeroCrossing(startZeroCrossing:endZeroCrossing) = y(startZeroCrossing:endZeroCrossing);

% 绘制标记后的信号
figure;
subplot(2, 1, 1);
plot(time, endpointMarkedSignalEnergy);
title('使用短时能量标记的信号');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(2, 1, 2);
plot(time, endpointMarkedSignalZeroCrossing);
title('使用过零点率标记的信号');
xlabel('时间 (秒)');
ylabel('幅度');
