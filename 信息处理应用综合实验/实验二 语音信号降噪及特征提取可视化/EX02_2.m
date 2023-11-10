% 读取录制的语音文件（你也可以使用之前的audioData）
[y, fs] = audioread('recorded_audio.wav');

% 设置预加重系数
preEmphasisCoefficient = 0.97;

% 应用预加重
preEmphasizedSignal = filter([1, -preEmphasisCoefficient], 1, y);

% 绘制预加重前后的时域波形
subplot(2, 1, 1);
plot(y);
title('原始语音信号');
xlabel('样本');
ylabel('幅度');

subplot(2, 1, 2);
plot(preEmphasizedSignal);
title('预加重后的语音信号');
xlabel('样本');
ylabel('幅度');

% 计算预加重前后的频谱
nfft = 1024; % FFT点数
Y = fft(y, nfft);
Y = Y(1:nfft/2+1); % 仅保留正频谱部分
f = (0:nfft/2) * fs / nfft;

preEmphasizedY = fft(preEmphasizedSignal, nfft);
preEmphasizedY = preEmphasizedY(1:nfft/2+1);

% 绘制预加重前后的频谱
figure;
subplot(2, 1, 1);
plot(f, abs(Y));
title('原始语音信号的频谱');
xlabel('频率 (Hz)');
ylabel('幅度');

subplot(2, 1, 2);
plot(f, abs(preEmphasizedY));
title('预加重后的语音信号的频谱');
xlabel('频率 (Hz)');
ylabel('幅度');