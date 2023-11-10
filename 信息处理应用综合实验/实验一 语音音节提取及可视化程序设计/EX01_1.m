% 读取 WAV 文件
[x, fs] = audioread('hushan.wav');

% 预加重参数
alpha = 0.97; % 预加重系数

% 预加重
x_preemph = filter([1, -alpha], 1, x);

% 计算预加重前后的频谱
N = 1024; % FFT点数，可以根据需要调整
X = abs(fft(x, N)); % 预加重前的频谱
X_preemph = abs(fft(x_preemph, N)); % 预加重后的频谱

% 绘制预加重前后的频谱
frequencies = linspace(0, fs, N);
subplot(2, 1, 1);
plot(frequencies, 20 * log10(X));
title('预加重前的频谱');
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');
subplot(2, 1, 2);
plot(frequencies, 20 * log10(X_preemph));
title('预加重后的频谱');
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');

% 记录预加重前后的波形
audiowrite('original_audio.wav', x, fs); % 原始语音
audiowrite('preemphasized_audio.wav', x_preemph, fs); % 预加重后的语音
