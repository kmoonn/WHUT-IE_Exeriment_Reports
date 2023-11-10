% 读取预加重后的语音文件（你也可以使用之前的preEmphasizedSignal）
[y, fs] = audioread('recorded_audio.wav');

% 添加噪声（模拟噪声信号，实际应用中会根据噪声类型采样不同的噪声信号）
noise = 0.1 * randn(size(y));

% 合成含噪声的语音信号
noisySignal = y + noise;

% 使用Wiener滤波进行降噪
estimatedSignal = wiener2(noisySignal, [3 3]);

% 绘制降噪前后的频谱
nfft = 1024; % FFT点数
Y_noisy = fft(noisySignal, nfft);
Y_noisy = Y_noisy(1:nfft/2+1); % 仅保留正频谱部分

Y_estimated = fft(estimatedSignal, nfft);
Y_estimated = Y_estimated(1:nfft/2+1);

f = (0:nfft/2) * fs / nfft;

% 绘制降噪前后的频谱
figure;
subplot(2, 1, 1);
plot(f, abs(Y_noisy));
title('含噪声语音信号的频谱');
xlabel('频率 (Hz)');
ylabel('幅度');

subplot(2, 1, 2);
plot(f, abs(Y_estimated));
title('降噪后的语音信号的频谱');
xlabel('频率 (Hz)');
ylabel('幅度');
