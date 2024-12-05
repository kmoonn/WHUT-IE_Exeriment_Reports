%���������ź�
[x, fs] = audioread ('recorded_audio.wav')
fid=fopen('test.txt','wt');    %���������ļ�
fprintf(fid,'%g\n',x (:,1));FS=length(x); t=(0:FS-1)/fs;
fclose(fid);
figure, plot(x) ;title("�����ɼ�");

%Ԥ����
r=fft(x); r1=abs(r); pinlv=(0:1:255)*8000/512;
yuanlai=20*log10(r1);signal(1:256)=yuanlai(1:256);
[h1,f1]=freqz([1,-0.98],[1],256,4000); pha=angle(h1);
H1=abs(h1); r2(1:256)=r(1:256); u=r2.*h1'; u2=abs(u);
u3=20*log10(u2); un=filter([1,-0.98],[1],x);
figure; subplot(2,2,1) ;plot(x) ;title('ԭʼ�����ź�');
%axis([0 256 -3*10^4 2*10^4]);
xlabel('������');  ylabel('����');
subplot(2,2,2) ;plot(un) ;title('����ͨ�˲���������ź�');
%axis([0 256 -1*10^4 1*10^4]);
xlabel('������');  ylabel('����');
subplot(2,2,3);plot(pinlv,signal) ;title('ԭʼ�����ź�Ƶ��');
xlabel('Ƶ��/Hz'); ylabel('����/dB') ;
subplot(2,2,4);plot(pinlv, u3) ;title('��Ԥ���غ�������ź�Ƶ��');
xlabel('Ƶ��/Hz'); ylabel('����/dB');

%�����˲�
L=length(x)
%������Ƶ�źŵĳ���
noise=0.05*randn(L,1); x_n=x+noise; N=fft(x_n);
figure,subplot(321); plot(t,x_n);
title('���������ź�ʱ����') ; xlabel('Ƶ��'); ylabel('��ֵ'); grid on;
subplot(322);plot(abs(N)) ;
title('�����ź�Ƶ��') ; xlabel('Ƶ��'); ylabel('����');
axis([0 150000 0 700]);grid on;
Fp=1500;Fs=1200;Ft=8000;As=100;Ap=1;
wp=2*pi*Fp/Ft; ws=2*pi*Fs/Ft;
[n,wn]=ellipord(wp,ws,Ap,As,'s');[b,a]=ellip (n,Ap,As,wn,'s');[B1,A1]=bilinear(b,a,1);[h,w]=freqz(B1,A1);
subplot (323); plot(w*Ft/pi/2, abs(h));
title('IIR��ͨ�˲���');xlabel('Ƶ��');ylabel('����');grid on;
subplot(324) ; plot(abs(N));
title('�����ź�Ƶ��'); xlabel('Ƶ��');ylabel('����');
axis([0 150000 0 700]); grid on;
subplot(325) ; y=filter(B1,A1,x_n); Y1=fft(y); plot(abs(Y1)) ;
title('�˲��ź�Ƶ��'); xlabel('Ƶ��');ylabel('����');
axis([0 150000 0 700]);grid on;

%��֡,�Ӵ�
X1=enframe(x,256,128);         %��y��֡��֡��256��֡��128
X2=X1(50,: ) ; figure;subplot(411);plot(X2) ; title('��֡��256��֡�ĵ�50֡');
x5=enframe(x, hamming(256),128);%ÿ���ٸ����Ϊһ֡���ټӺ�����
subplot(412);plot(x5(50,:));title('�����źżӺ��������50֡(256��֡)');%����50֡����
r=fft(X1); r1=abs(r); pinlv1=(0: 1:255)*8000/512;
yuanlai=20*log10(r1); signal1(1:256)=yuanlai(1: 256);
subplot(413);plot(pinlv,signal); title('ԭʼ�����ź�Ƶ��');
subplot(414) ;plot (pinlv1,signal1) ;title('��֡�����ź�Ƶ��');

[x fs] = audioread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\luyin..wav');
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
x = enframe(x,256,80);%֡��256,֡��80
figure, plot(x) ;
for i = 1 : size(x,1)
    y = x(i,:);
    s = y.'.*hamming(256);
    t = abs(fft(s)).^2;
    c1 = dctcoef*log(bank*t(1:129)) ;
    c2 = c1.*w';
    m(i,:) = c2';
end
title('MFcc������ȡ');
xlabel('֡��');ylabel('��ֵ');

