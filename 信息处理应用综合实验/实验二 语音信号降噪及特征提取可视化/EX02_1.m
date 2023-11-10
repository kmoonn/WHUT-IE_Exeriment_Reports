% 指定采样率和位深度
sampleRate = 44100; % 采样率，以每秒样本数为单位
bitDepth = 16; % 位深度

% 创建录音对象
recObj = audiorecorder(sampleRate, bitDepth, 1); % 第三个参数是通道数，通常为1

% 提示用户开始录音
disp('开始录音...');
record(recObj);

% 录音持续一定时间（例如10秒），你也可以设置不同的持续时间
pause(5);

% 停止录音
stop(recObj);
disp('录音结束.');

% 获取录制的语音数据
audioData = getaudiodata(recObj);

% 播放录制的语音
play(recObj);

% 可以保存录制的语音数据到一个文件
audiowrite('recorded_audio.wav', audioData, sampleRate);

% 清理录音对象
clear recObj;
