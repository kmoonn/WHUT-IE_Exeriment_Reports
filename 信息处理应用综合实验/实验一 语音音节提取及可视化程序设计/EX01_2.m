% 读取 WAV 文件
[x, fs] = audioread('hushan.wav');

% 帧参数
frame_length = 0.025; % 帧长度（秒）
frame_shift = 0.01;  % 帧移（秒）
frame_length_samples = round(frame_length * fs); % 帧长度（样本数）
frame_shift_samples = round(frame_shift * fs);   % 帧移（样本数）

% 确保帧长度不超过信号长度
if frame_length_samples > length(x)
    error('帧长度过长，超过了信号长度。');
end

% 使用矩形窗进行分帧
rectangular_window = rectwin(frame_length_samples);
num_frames = floor((length(x) - frame_length_samples) / frame_shift_samples) + 1;

rectangular_frames = zeros(num_frames, frame_length_samples);
for i = 1:num_frames
    start_sample = (i - 1) * frame_shift_samples + 1;
    end_sample = start_sample + frame_length_samples - 1;
    rectangular_frames(i, :) = x(start_sample:end_sample) .* rectangular_window;
end


% 使用汉明窗进行分帧
hamming_window = hamming(frame_length_samples);
num_frames = floor((length(x) - frame_length_samples) / frame_shift_samples) + 1;

hamming_frames = zeros(num_frames, frame_length_samples);
for i = 1:num_frames
    start_sample = (i - 1) * frame_shift_samples + 1;
    end_sample = start_sample + frame_length_samples - 1;
    if end_sample > length(x)
        break; % 避免超出信号长度
    end
    hamming_frames(i, :) = x(start_sample:end_sample) .* hamming_window';
end

% 绘制矩形窗和汉明窗处理后的波形
figure;
subplot(2, 1, 1);
plot(rectangular_frames(1, :));
title('矩形窗处理后的波形');
xlabel('样本数');
ylabel('幅度');

subplot(2, 1, 2);
plot(hamming_frames(1, :));
title('汉明窗处理后的波形');
xlabel('样本数');
ylabel('幅度');

% 保存处理后的波形为 WAV 文件
audiowrite('rectangular_window_audio.wav', rectangular_frames(1, :), fs);
audiowrite('hamming_window_audio.wav', hamming_frames(1, :), fs);