%载入语音信号
[x, fs] = audioread ('recorded_audio.wav')
fid=fopen('test.txt','wt');    %读入语音文件
fprintf(fid,'%g\n',x (:,1));FS=length(x); t=(0:FS-1)/fs;
fclose(fid);
figure, plot(x) ;title("语音采集");

%预加重
r=fft(x); r1=abs(r); pinlv=(0:1:255)*8000/512;
yuanlai=20*log10(r1);signal(1:256)=yuanlai(1:256);
[h1,f1]=freqz([1,-0.98],[1],256,4000); pha=angle(h1);
H1=abs(h1); r2(1:256)=r(1:256); u=r2.*h1'; u2=abs(u);
u3=20*log10(u2); un=filter([1,-0.98],[1],x);
figure; subplot(2,2,1) ;plot(x) ;title('原始语音信号');
%axis([0 256 -3*10^4 2*10^4]);
xlabel('样点数');  ylabel('幅度');
subplot(2,2,2) ;plot(un) ;title('经高通滤波后的语音信号');
%axis([0 256 -1*10^4 1*10^4]);
xlabel('样点数');  ylabel('幅度');
subplot(2,2,3);plot(pinlv,signal) ;title('原始语音信号频谱');
xlabel('频率/Hz'); ylabel('幅度/dB') ;
subplot(2,2,4);plot(pinlv, u3) ;title('经预加重后的语音信号频谱');
xlabel('频率/Hz'); ylabel('幅度/dB');

%降噪滤波
L=length(x)
%计算音频信号的长度
noise=0.05*randn(L,1); x_n=x+noise; N=fft(x_n);
figure,subplot(321); plot(t,x_n);
title('加噪语音信号时域波形') ; xlabel('频率'); ylabel('幅值'); grid on;
subplot(322);plot(abs(N)) ;
title('加噪信号频谱') ; xlabel('频率'); ylabel('幅度');
axis([0 150000 0 700]);grid on;
Fp=1500;Fs=1200;Ft=8000;As=100;Ap=1;
wp=2*pi*Fp/Ft; ws=2*pi*Fs/Ft;
[n,wn]=ellipord(wp,ws,Ap,As,'s');[b,a]=ellip (n,Ap,As,wn,'s');[B1,A1]=bilinear(b,a,1);[h,w]=freqz(B1,A1);
subplot (323); plot(w*Ft/pi/2, abs(h));
title('IIR低通滤波器');xlabel('频率');ylabel('幅度');grid on;
subplot(324) ; plot(abs(N));
title('加噪信号频谱'); xlabel('频率');ylabel('幅度');
axis([0 150000 0 700]); grid on;
subplot(325) ; y=filter(B1,A1,x_n); Y1=fft(y); plot(abs(Y1)) ;
title('滤波信号频谱'); xlabel('频率');ylabel('幅度');
axis([0 150000 0 700]);grid on;

%分帧,加窗
X1=enframe(x,256,128);         %对y分帧，帧长256，帧移128
X2=X1(50,: ) ; figure;subplot(411);plot(X2) ; title('以帧长256分帧的第50帧');
x5=enframe(x, hamming(256),128);%每两百个点分为一帧，再加海明窗
subplot(412);plot(x5(50,:));title('语音信号加汉明窗后第50帧(256分帧)');%画第50帧波形
r=fft(X1); r1=abs(r); pinlv1=(0: 1:255)*8000/512;
yuanlai=20*log10(r1); signal1(1:256)=yuanlai(1: 256);
subplot(413);plot(pinlv,signal); title('原始语音信号频谱');
subplot(414) ;plot (pinlv1,signal1) ;title('分帧语音信号频谱');

[x fs] = audioread('D:\desktop\数字处理应用综合实训\luyin..wav');
figure,plot(x);
bank = melbankm(24,256,fs,0,0.5,'t');
bank = full(bank);
bank = bank/max(bank(:));
for k = 1:12
    n = 0:23;
    dctcoef(k,:) = cos((2*n+1)*k*pi/(2*24)) ;
end
p = 1:12;
w = 1+6*sin(pi*p./12);w = w/max(w);
x = filter([1 -0.9375],1,x);
x = enframe(x,256,80);%帧长256,帧移80
figure, plot(x) ;
for i = 1 : size(x,1)
    y = x(i,:);
    s = y.'.*hamming(256);
    t = abs(fft(s)).^2;
    c1 = dctcoef*log(bank*t(1:129)) ;
    c2 = c1.*w';
    m(i,:) = c2';
end
title('MFcc特征提取');
xlabel('帧数');ylabel('幅值');

