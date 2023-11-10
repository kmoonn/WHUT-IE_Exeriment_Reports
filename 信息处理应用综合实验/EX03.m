x=imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg') ;
I=rgb2gray(x) ; subplot(3,3,1) ; imshow(I) ;title('原始图像');
J1=imnoise(I, 'gaussian' ,0,0.02); subplot(3,3,2); imshow(J1);title('加入高斯噪声后');
J2=imnoise(I, 'salt & pepper' ,0.02) ; subplot(3,3,3) ; imshow(J2);title('加入椒盐噪声后');
K1=filter2(fspecial('average' ,5),J1)/255;subplot(3,3,4) ; imshow(K1) ;title('均值滤波去高斯噪声');
K2=medfilt2(J1 ); subplot(3,3,5) ; imshow(K2) ;title('中值滤波去高斯噪声');
K3=wiener2(J1,[3 3]); subplot(3,3,6) ; imshow(K3); title('维纳滤波去高斯噪声');
Ks1=filter2(fspecial('average' ,3),J2)/255; subplot(3,3,7) ; imshow(Ks1) ;title('均值滤波去椒盐噪声');
Ks2=medfilt2(J2); subplot(3,3,8) ; imshow(Ks2) ; title('中值滤波去椒盐噪声');
Ks3=wiener2(J2,[3 3]); subplot(3,3,9) ; imshow(Ks3);title('维纳滤波去椒盐噪声');

%频域分析
m = caculate(I);m1 = caculate(J1);
m2 = caculate(J2);m10 = caculate(K1);
m11 = caculate(K2);m12 = caculate(K3);
m20 = caculate(Ks1); m21 = caculate(Ks2);
m22 = caculate(Ks3);

figure;
subplot(3,3,1),imshow(m,[]),  title('原始图像');
subplot(3,3,2),imshow(m1,[]), title('加入高斯噪声后');
subplot(3,3,3),imshow(m2,[]), title('加入椒盐噪声后');
subplot(3,3,4),imshow(m10,[]),title('均值滤波去高斯噪声');
subplot(3,3,5),imshow(m11,[]),title('中值滤波去高斯噪声');
subplot(3,3,6),imshow(m12,[]),title('维纳滤波去高斯噪声');
subplot(3,3,7),imshow(m20,[]),title('均值滤波去椒盐噪声');
subplot(3,3,8),imshow(m21,[]),title('中值滤波去椒盐噪声');
subplot(3,3,9),imshow(m22,[]),title('维纳滤波去椒盐噪声');

%锐化%
f_average = fspecial('average', [3 3])
f_sobel = fspecial('sobel')
f_laplacian = fspecial('laplacian', 0)

x = imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg') ;
A = rgb2gray(x);
%A=imnoise(I, 'salt & pepper',0.02);
B1 = imfilter(A, f_average) ;
B2 = imfilter(A, f_sobel);
B3 = imfilter(A, f_laplacian) ;
figure;
subplot(221) ; imshow(A);
subplot(222) ; imshow(B1);
subplot(223) ; imshow(A-B2);
subplot(224) ; imshow(A-B3);

I = imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg');I=rgb2gray(I);
m = caculate(I);
figure(1);subplot(321),imshow(I);title('原图像');
I=imnoise(I,'gaussian') ;%%加入高斯白噪声
subplot(322),imshow(I);title('加入噪声后的图像');
s=fftshift(fft2(I));subplot(324),imshow(m,[]),title('原始图像频谱');
subplot(325), imshow(log(abs(s)),[]); title('加噪图像频谱');
[a,b]=size(s);a0=round(a/2);b0=round(b/2);d=50;
%低通
for i=1: a
    for j=1:b
        distance=sqrt((i-a0)^2+(j-b0)^2);
        if distance<=d
           h=1;
        else
           h=0;
        end
        s(i,j)=h*s(i,j);
    end
end
s=uint8(real(ifft2(ifftshift(s)) ));
subplot(323),imshow(s);title('理想低通滤波所得图像');
s=fftshift(fft2(s));
subplot(326),imshow(log(abs(s)),[]); title('理想低通滤波所得图像的频谱');


im1=imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg');im1=rgb2gray(im1);im2=im1;m = caculate(im1)
figure;subplot(321); imshow(im1);title('原图像');
im1=imnoise(im1,'gaussian') ;%%加入高斯白噪声
subplot(322),imshow(im1);title('加入噪声后的图像');
r=80;%设置滤波圆半径参数为80
img_f=fftshift(fft2(double(im1)));%傅里叶变换得到频谱
subplot(324),imshow(m,[]),title('原始图像频谱');
subplot(325),imshow(log(abs(img_f)),[]); title('加噪图像频谱');
[m, n]=size(img_f);P_x=fix(m/2); P_y=fix (n/2);%获取圆心坐标
img_1pf=zeros(m,n);%提前定义滤波后的频谱，提高运行速度
for j=1:n
    for i=1 : m
        d=sqrt((i-P_x)^2+(j-P_y)^2);%计算两点之间的距离，判断在圆外还是圆内
        if d<=r
            H(i,j)=0;%圆内置零，去除低频分量
        else
            H(i,j)=1;%圆外不变
        end
        img_1pf(i,j)=H(i,j)*img_f(i,j);
    end
end
img_1pf=ifftshift(img_1pf) ;           %傅里叶反变换
img_1pf=uint8(real(ifft2(img_1pf)));   %取实数部分
subplot(323) ; imshow(im2-img_1pf) ;title('理想高通滤波所得图像')
imwrite(img_1pf,'理想高通滤波.jpg') ; img_1pf=fftshift(fft2(img_1pf)) ;
subplot(326), imshow(log(abs(img_1pf)),[]);title('高通滤波所得图像的频谱');

im1=imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg');im1=rgb2gray(im1);im2=im1;
m = caculate(im1);figure ; subplot(321) ; imshow(im1) ; title('原图像');
im1=imnoise(im1,'salt & pepper', 0.02);%%加入高斯白噪声
subplot(322), imshow(im1);title('加入噪声后的图像');
x=80;%设置滤波圆半径参数为80
img_f=fftshift(fft2(double(im1)));%傅里叶变换得到频谱
subplot(324), imshow(m,[]), title('原始图像频谱');
subplot(325), imshow(log(abs(img_f)),[]); title('加噪图像频谱');
src = im2double(imread('D:\desktop\数字处理应用综合实训\实验三\zx.jpg')); src = rgb2gray(src);
src=imnoise(src,'salt & pepper',0.02);%%加入高斯白噪声
[w h] = size(src) ; srcf = fft2(src) ; srcf = fftshift(srcf);
flt = ones(size(src)) ;r = min(w, h)/12;rx1 = r;ry1 =h/2;
for i = 1:w
    for j = 1:h
        if(rx1-i)^2+(ry1 - j)^2<= r*r
            flt(i,j)= 0;
        end
        if(w-rx1-i)^2 +(h-ry1 - j)^2<= r*r
            flt(i,j) = 0;
        end
    end
end
dfimg = srcf.*flt; dfimg = ifftshift(dfimg) ; dimg = ifft2(dfimg, 'symmetric');
subplot(323) ; imshow(dimg) ;title('陷波滤波所得图像');
dimg=uint8(real(dimg)) ;%取实数部分
dimg=fftshift(fft2(dimg)) ; subplot(326) ; imshow(dimg);title('陷波滤波所得图像的频谱');

