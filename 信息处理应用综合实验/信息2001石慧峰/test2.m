close all;   %关闭当前所有图形窗口
clear all;    %清楚工作空间变量
clc;            %清除命令行数据
[y,fs]=audioread('hushan.wav');%读取语音wav文件

% figure;
% plot(x);
window_size = 0.02; % 窗口大小，单位秒
window_overlap = 0.5*window_size; % 窗口重叠大小，单位秒
frame_length = round(window_size * fs); %帧长度

N = frame_length;
inc=0.5*N;  %帧移
p = 32;  %梅尔滤波器个数


N2=length(y);  %语音信号长度

y_preemphasized = filter([1, -0.9], 1, y); % 预加重

% audiowrite('D:\桌面\t1.wav',y_preemphasized,fs);
figure;
subplot(121)
plot(y),title('原始语音');
subplot(122)
plot(y_preemphasized),title('预加重后语音');
f = abs(fft(y));
f_pre = abs(fft(y_preemphasized));
figure
subplot(121)
plot(f),title('原始语音频谱');
subplot(122)
plot(f_pre),title('预加重语音频谱');

% 设计一个均值滤波器
window_size = 20; % 设置窗口大小
b = (1/window_size) * ones(1, window_size);

% 应用滤波器进行降噪
denoised_signal = filter(b, 1, y_preemphasized);

figure
subplot(121),plot(f_pre),title('去噪前语音频谱');
subplot(122),plot(abs(fft(denoised_signal))),title('滤波后语音频谱');

S=enframe(y,frame_length,inc);%分帧,对语音信号x进行分帧，
[a,b]=size(S);  %a为矩阵行数，b为矩阵列数
%创建汉明窗矩阵C
C=zeros(a,b);
ham=hamming(b);
for i=1:a
    C(i,:)=ham;
end
%将汉明窗C和S相乘得SC
SC=S.*C;
figure
subplot(121),plot(S(10,:)),title('加窗前一帧内信号');
subplot(122),plot(SC(10,:)),title('加窗后一帧内信号');

F=0;N=frame_length;
for i=1:a
    %对SC作N=1024的FFT变换
    D(i,:)=fft(SC(i,:),N);
    %以下循环实现求取谱线能量
    for j=1:N
        t=abs(D(i,j));
        E(i,j)=(t^2);
    end
end


fl=0;fh=fs/2;%定义频率范围，低频和高频
bl=2595*log10(1+fl/700);%得到梅尔刻度的最小值
bh=2595*log10(1+fh/700);%得到梅尔刻度的最大值
%梅尔坐标范围
% p=26;%滤波器个数
B=bh-bl;%梅尔刻度长度
mm=linspace(0,B,p+2);%规划34个不同的梅尔刻度。但只有32个梅尔滤波器
fm=700*(10.^(mm/2595)-1);%将Mel频率转换为频率
W2=N/2+1;%fs/2内对应的FFT点数,1024个频率分量

k=((N+1)*fm)/fs;%计算34个不同的k值
hm=zeros(p,N);%创建hm矩阵
df=fs/N;
freq=(0:N-1)*df;%采样频率值

%绘制梅尔滤波器
for i=2:p+1
    %取整
    n0=floor(k(i-1));  %floor为向下取整，如果取整，表示三角滤波器组的各中心点被置于FFT 数据对应的的点位频率上，所以频率曲线的三角形顶点正好在FFT 数据点上，即美尔滤波器所有顶点在同一高度。
    n1=floor(k(i));
    n2=floor(k(i+1));

   
    for j=1:N
       if n0<=j & j<=n1
           hm(i-1,j)=(j-n0)/(n1-n0);
       elseif n1<=j & j<=n2
           hm(i-1,j)=(n2-j)/(n2-n1);
       end
   end
   %此处求取H1(k)结束。
end

 %梅尔滤波器滤波
 H=E*hm';
 %对H作自然对数运算
 %因为人耳听到的声音与信号本身的大小是幂次方关系，所以要求个对数
 for i=1:a
     for j=1:p
         H(i,j)=log(H(i,j));
     end
 end
 %作离散余弦变换 
Fbank = H';

figure;
plot(Fbank);
imagesc(Fbank);
axis xy;   %y轴从下往上
colorbar;
xlabel('语音分帧帧数');
ylabel('fbank参数维数');

Fbank1 = dct(Fbank);
mfcc = Fbank1';
figure;
plot(mfcc);
imagesc(mfcc');
axis xy;   %y轴从下往上
colorbar;
xlabel('语音分帧帧数');
ylabel('mfcc参数维数');
