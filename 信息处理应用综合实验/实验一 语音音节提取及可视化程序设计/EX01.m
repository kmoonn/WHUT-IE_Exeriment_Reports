%载入语音信号
[x,fs]=audioread ('hushan.wav');
fid=fopen('test.txt','wt');    %读入语音文件
fprintf(fid,'%g\n',x(:,1));
fclose(fid);

%预加重
r=fft(x) ; r1=abs(r); pinlv=(0: 1:255)*8000/512;
yuanlai=20*log10(r1); signa1(1:256)=yuanlai(1:256) ;
[h1,f1]=freqz([1,-0.98],1,256,4000); pha=angle(h1) ;
H1=abs(h1); r2(1:256)=r(1:256); u=r2.*h1'; u2=abs (u) ;
u3=20*log10(u2); un=filter([1,-0.98],1,x);

figure(1) ; subplot(3,2,1);
plot(f1,H1) ;title('高通滤波器的幅频特性');
xlabel('频率/Hz') ;ylabel('幅度');
subplot(3,2,2);plot(pha) ; title('高通滤波器的相频特性');
xlabel('频率/Hz') ; ylabel('角度/rad' ) ;
figure(1) ; subplot(3,2,3);plot(x) ; title('原始语音信号');
%axis([O 256 -3*10^4 2=10^4]);
xlabel('样点数');ylabel('幅度');
subplot(3,2,4);plot(un) ;title('经高通滤波后的语音信号');
%axis([O 256 -1*10^4 1*10^4]);
xlabel('样点数'); ylabel('幅度');
figure(1); subplot(3,2,5);plot(pinlv,signa1); title('原始语音信号频谱');
xlabel('频率/Hz'); ylabel('幅度/cB');
subplot(3,2,6);plot(pinlv,u3);title('经预加重后的语音信号频谱');
xlabel('频率/Hz'); ylabel('幅度/dB')

%分帧,加窗
X1=enframe(x,256,128);                 %对y分帧，帧长256，帧移128
X2=X1(50,: ) ;figure(2) ; subplot(411);plot(X2) ;title('以帧长256分帧的第50帧');
x6=enframe (x,512,256);                %对y分帧，帧长512，帧移256
X3=x6(50,: );subplot(412);plot(X3); title('以帧长512分帧的第50帧’');
x4=enframe(x, boxcar(256),128);%每两百个点分为一帧，再加矩形窗
subplot(413);plot(x4(50,:));title('语音信号加矩形窗后第50帧');%画第50帧波形
x5=enframe (x, hamming(256),128) ;%每两百个点分为一帧，再加海明窗
subplot(414);plot(x5(50,:));title('语音信号加汉明窗后第50帧');%画第5o帧波形

%不同窗函数，帧长下的能量和过零率
s2=X1.^2; energy1=sum(s2,2); zero1 = zcro(X1); figure(3) ;
subplot(421);plot(energy1);title('256分帧短时能量');
subplot(422);plot(zero1);title('256分帧短时过零率');
s2=x6.^2; energy2=sum(s2,2); zero2= zcro(x6);
subplot(423);plot(energy2);title('512分帧短时能量');
subplot(424);plot(zero2); title('512分帧短时过零率');
s3=x4.^2; energy3=sum(s3,2); zero3 = zcro(x4);
subplot(425);plot(energy3); title('加矩形窗后短时能量');
subplot(426);plot(zero3); title('加矩形窗后短时过零率');
s4=x5.^2; energy4=sum(s4,2); zero4 = zcro(x5);
subplot(427);plot(energy4);title('加汉明窗后短时能量');
subplot(428);plot(zero3) ;title('加汉明窗后短时过零率');

%不同窗函数，帧长下的自相关函数
x1=enframe(x, boxcar(200),100);
X2=enframe(x, hanning(200),100);
X3=enframe(x,200,100);
u1=X1(100,: );
u2=X2(50,: );
u3=X3(50,: );
figure(4);
R1=xcorr(u1);
R1=R1(200: end) ;
R2=xcorr(u2);
R2=R2(200: end)
subplot(311);plot(u3);title('第50帧帧信号');
subplot(312);plot(R1);title('加矩形窗的自相关函数');
subplot(313);plot(R2);title('加汉明窗的自相关函数');

x=audioread('hushan.wav');
%幅度归一化到[-1,1]
x = double(x) ; x = x / max(abs(x));
%常数设置
FrameLen = 4000;FrameInc = 2000 ; amp1 = 10; amp2 = 2;
zcr1 = 10;zcr2= 5; maxsilence = 3000;    %6*10ms - 30ms
minlen = 1000;    %15*1Oms = 150ms
status= 0; count = 0;silence = 0;
%计算过零率
tmp1  = enframe (x(1 : end-1),FrameLen,FrameInc);
tmp2  = enframe (x(2 : end)  ,FrameLen,FrameInc);
signs = (tmp1.*tmp2)<0;diffs = (tmp1 -tmp2)>0.02;
zcr   = sum (signs.*diffs,2) ;
%计算短时能量
amp = sum (abs(enframe(filter([1 -0.9375],1,x),FrameLen,FrameInc)),2);
%调整能量门限
amp1 = min(amp1, max(amp)/4); amp2 = min(amp2,max(amp)/8);
%开始端点检测
x1 = 0; x2 = 0;
for n=1:length(zcr)
    goto = 0;
    switch status
    case {0,1}             % 0=静音，1 =可能开始
       if amp(n) > amp1    %确信进入语音段
         x1 = max (n-count-1,1);
         status = 2;
         silence = 0;
         count = count + 1;
       elseif amp(n) > amp2 |... %可能处于语音段
              zcr(n) > zcr2
         status = 1;
         count = count + 1;
       else                       %静音状态
          status= 0;
          count = 0;
       end
    case 2,                         %2=语音段
      if amp (n) > amp2  |...       %保持在语音段
         zcr (n) > zcr2
         count = count + 1;
      else                        %语音将结束
         silence = silence + 1 ;
         if silence < maxsilence  %静音还不够长，尚未结束
            count = count + 1;
         elseif count < minlen       %语音长度太短，认为是噪声
            status = 0;
            silence = 0;
            count = 0;
         else                        %语音结束
            status= 3;
         end
      end
    case 3,
       break;
    end
end
count = count-silence/2; x2 = x1 + count -1 ; subplot(311)
plot(x) ; axis([1 length(x) -1 1]) ;ylabel ('Speech') ;
line([x1*FrameInc x1*FrameInc],[-1 1], 'Color', 'red' ) ;
line([x2*FrameInc x2*FrameInc],[-1 1], 'Color', 'green') ;
subplot(312) ;plot(amp) ; axis([1 length(amp) 0 max(amp)])
ylabel('Energy' ); line([x1 x1],[min(amp) , max(amp)],'Color', 'red');
line([x2 x2],[min(amp) ,max(amp)], 'Color', ' green');
subplot(313);plot(zcr) ; axis([1 length(zcr) 0 max(zcr)])
ylabel('ZCR' ); line([x1 x1],[min(zcr) , max(zcr)],'Color', 'red' );
line([x2 x2],[min(zcr) , max(zcr)], 'Color', 'green');