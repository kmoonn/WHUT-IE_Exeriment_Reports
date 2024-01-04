%1. 语音信号采集（这里假设已有录音文件）
audioFilePath = 'voice.wav';
[y, fs] = audioread(audioFilePath);
y = y(:,1);
N = length(y);
f = fs/N*(1:round(N/2)-1);
figure
plot(y),;

% 2. 预处理
y_preemphasized = filter([1, -0.97], 1, y); % 预加重

% 计算FFT
y_fre = abs(fft(y));
y_pre_fre = abs(fft(y_preemphasized));

figure;
subplot(121)
plot(f,y_fre(1:round(N/2)-1))
title('原始语音频谱')
subplot(122)
plot(f,y_pre_fre(1:round(N/2)-1))
title('预加重语音频谱')

window_size = 0.02; % 窗口大小，单位秒
window_overlap = 0.5*window_size; % 窗口重叠大小，单位秒
frame_length = round(window_size * fs); %帧长度

window_hamming = hamming(frame_length, 'periodic');
window_rectwin = rectwin(frame_length);
frame = buffer(y_preemphasized, frame_length, round(window_overlap * fs), 'nodelay');
num_frames = size(frame, 2);%帧数
frames_hamming = frame.*repmat(window_hamming,1,num_frames);
frames_rectwin = frame.*repmat(window_rectwin,1,num_frames);

figure; 
subplot(1,2,1)
nfft = 2^nextpow2(frame_length); % 重叠点数
nooverlap = frame_length/2; % 重叠长度
[S, F, T, P] = spectrogram(y_preemphasized, window_hamming, nooverlap, nfft, fs); 
imagesc(T, F, log10(abs(S))) % 绘图函数
colorbar;
set(gca, 'YDir', 'normal') % 坐标轴设置
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('汉明窗语谱图')

subplot(1,2,2)
[S, F, T, P] = spectrogram(y_preemphasized, window_rectwin, nooverlap, nfft, fs); 
imagesc(T, F, log10(abs(S))) % 绘图函数
colorbar;
set(gca, 'YDir', 'normal') % 坐标轴设置
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('矩形窗语谱图')



% 3. 语音端点检测
% 设计基于能量和过零率的端点检测

energy_threshold_min = 0.00017;
energy_threshold_max = 0.0001;
zero_crossing_threshold = 20;

energy_hamming = sum(frames_hamming.^2);
energy_rectwin = sum(frames_rectwin.^2);

zero_crossings_hamming = sum(abs(diff(sign(frames_hamming))) / 2);
zero_crossings_rectwin = sum(abs(diff(sign(frames_rectwin))) / 2);



endpoints = [];
lastframe = 0;
for i = 1:1:num_frames

    if energy_hamming(1,i)>energy_threshold_min & lastframe==0
        endpoints = [endpoints i];
        lastframe = 1       
    end  
    if energy_hamming(1,i)<energy_threshold_max & lastframe==1
        endpoints = [endpoints i];
        lastframe = 0
        endpoints
    end  
end

figure;
subplot(221)
plot(energy_hamming);
title('汉明窗短时能量');
subplot(222)
plot(energy_rectwin);
title('矩形窗短时能量');
subplot(223)
plot(zero_crossings_hamming);
title('汉明窗短时过零率');
subplot(224)
plot(zero_crossings_rectwin);
title('矩形窗短时过零率');


figure

plot(y_preemphasized);
title('端点检测')


x_positions = endpoints*0.5*frame_length;

hold on; % 保持图形窗口开启，以便在同一图形上添加竖线

for i = 1:length(x_positions)
    % 画竖线
    line([x_positions(i), x_positions(i)], ylim, 'Color', 'r', 'LineStyle', '--');
end

hold off;

% 计算短时自相关函数


R_hamming = []
for i = 1:num_frames
    u = frames_hamming(:,i);
    R_hamming = cat(1,R_hamming,xcorr(u));
end

R_rectwin = []
for j = 1:num_frames
    u = frames_rectwin(:,j);
    R_rectwin = cat(1,R_rectwin,xcorr(u));
end
figure;
subplot(121);
plot(R_hamming);
title('帧长50ms,汉明窗短时自相关函数')
subplot(122);
plot(R_rectwin);
title('帧长50ms,矩形窗短时自相关函数')







