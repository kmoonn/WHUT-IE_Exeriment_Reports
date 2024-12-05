x=imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg') ;
I=rgb2gray(x) ; subplot(3,3,1) ; imshow(I) ;title('ԭʼͼ��');
J1=imnoise(I, 'gaussian' ,0,0.02); subplot(3,3,2); imshow(J1);title('�����˹������');
J2=imnoise(I, 'salt & pepper' ,0.02) ; subplot(3,3,3) ; imshow(J2);title('���뽷��������');
K1=filter2(fspecial('average' ,5),J1)/255;subplot(3,3,4) ; imshow(K1) ;title('��ֵ�˲�ȥ��˹����');
K2=medfilt2(J1 ); subplot(3,3,5) ; imshow(K2) ;title('��ֵ�˲�ȥ��˹����');
K3=wiener2(J1,[3 3]); subplot(3,3,6) ; imshow(K3); title('ά���˲�ȥ��˹����');
Ks1=filter2(fspecial('average' ,3),J2)/255; subplot(3,3,7) ; imshow(Ks1) ;title('��ֵ�˲�ȥ��������');
Ks2=medfilt2(J2); subplot(3,3,8) ; imshow(Ks2) ; title('��ֵ�˲�ȥ��������');
Ks3=wiener2(J2,[3 3]); subplot(3,3,9) ; imshow(Ks3);title('ά���˲�ȥ��������');

%Ƶ�����
m = caculate(I);m1 = caculate(J1);
m2 = caculate(J2);m10 = caculate(K1);
m11 = caculate(K2);m12 = caculate(K3);
m20 = caculate(Ks1); m21 = caculate(Ks2);
m22 = caculate(Ks3);

figure;
subplot(3,3,1),imshow(m,[]),  title('ԭʼͼ��');
subplot(3,3,2),imshow(m1,[]), title('�����˹������');
subplot(3,3,3),imshow(m2,[]), title('���뽷��������');
subplot(3,3,4),imshow(m10,[]),title('��ֵ�˲�ȥ��˹����');
subplot(3,3,5),imshow(m11,[]),title('��ֵ�˲�ȥ��˹����');
subplot(3,3,6),imshow(m12,[]),title('ά���˲�ȥ��˹����');
subplot(3,3,7),imshow(m20,[]),title('��ֵ�˲�ȥ��������');
subplot(3,3,8),imshow(m21,[]),title('��ֵ�˲�ȥ��������');
subplot(3,3,9),imshow(m22,[]),title('ά���˲�ȥ��������');

%��%
f_average = fspecial('average', [3 3])
f_sobel = fspecial('sobel')
f_laplacian = fspecial('laplacian', 0)

x = imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg') ;
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

I = imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg');I=rgb2gray(I);
m = caculate(I);
figure(1);subplot(321),imshow(I);title('ԭͼ��');
I=imnoise(I,'gaussian') ;%%�����˹������
subplot(322),imshow(I);title('�����������ͼ��');
s=fftshift(fft2(I));subplot(324),imshow(m,[]),title('ԭʼͼ��Ƶ��');
subplot(325), imshow(log(abs(s)),[]); title('����ͼ��Ƶ��');
[a,b]=size(s);a0=round(a/2);b0=round(b/2);d=50;
%��ͨ
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
subplot(323),imshow(s);title('�����ͨ�˲�����ͼ��');
s=fftshift(fft2(s));
subplot(326),imshow(log(abs(s)),[]); title('�����ͨ�˲�����ͼ���Ƶ��');


im1=imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg');im1=rgb2gray(im1);im2=im1;m = caculate(im1)
figure;subplot(321); imshow(im1);title('ԭͼ��');
im1=imnoise(im1,'gaussian') ;%%�����˹������
subplot(322),imshow(im1);title('�����������ͼ��');
r=80;%�����˲�Բ�뾶����Ϊ80
img_f=fftshift(fft2(double(im1)));%����Ҷ�任�õ�Ƶ��
subplot(324),imshow(m,[]),title('ԭʼͼ��Ƶ��');
subplot(325),imshow(log(abs(img_f)),[]); title('����ͼ��Ƶ��');
[m, n]=size(img_f);P_x=fix(m/2); P_y=fix (n/2);%��ȡԲ������
img_1pf=zeros(m,n);%��ǰ�����˲����Ƶ�ף���������ٶ�
for j=1:n
    for i=1 : m
        d=sqrt((i-P_x)^2+(j-P_y)^2);%��������֮��ľ��룬�ж���Բ�⻹��Բ��
        if d<=r
            H(i,j)=0;%Բ�����㣬ȥ����Ƶ����
        else
            H(i,j)=1;%Բ�ⲻ��
        end
        img_1pf(i,j)=H(i,j)*img_f(i,j);
    end
end
img_1pf=ifftshift(img_1pf) ;           %����Ҷ���任
img_1pf=uint8(real(ifft2(img_1pf)));   %ȡʵ������
subplot(323) ; imshow(im2-img_1pf) ;title('�����ͨ�˲�����ͼ��')
imwrite(img_1pf,'�����ͨ�˲�.jpg') ; img_1pf=fftshift(fft2(img_1pf)) ;
subplot(326), imshow(log(abs(img_1pf)),[]);title('��ͨ�˲�����ͼ���Ƶ��');

im1=imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg');im1=rgb2gray(im1);im2=im1;
m = caculate(im1);figure ; subplot(321) ; imshow(im1) ; title('ԭͼ��');
im1=imnoise(im1,'salt & pepper', 0.02);%%�����˹������
subplot(322), imshow(im1);title('�����������ͼ��');
x=80;%�����˲�Բ�뾶����Ϊ80
img_f=fftshift(fft2(double(im1)));%����Ҷ�任�õ�Ƶ��
subplot(324), imshow(m,[]), title('ԭʼͼ��Ƶ��');
subplot(325), imshow(log(abs(img_f)),[]); title('����ͼ��Ƶ��');
src = im2double(imread('D:\desktop\���ִ���Ӧ���ۺ�ʵѵ\ʵ����\zx.jpg')); src = rgb2gray(src);
src=imnoise(src,'salt & pepper',0.02);%%�����˹������
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
subplot(323) ; imshow(dimg) ;title('�ݲ��˲�����ͼ��');
dimg=uint8(real(dimg)) ;%ȡʵ������
dimg=fftshift(fft2(dimg)) ; subplot(326) ; imshow(dimg);title('�ݲ��˲�����ͼ���Ƶ��');

