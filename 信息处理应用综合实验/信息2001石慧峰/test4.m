%基于小波分解和小波阈值去噪实现图像去噪
close all;   %关闭当前所有图形窗口
clear all;    %清楚工作空间变量
clc;            %清除命令行数据

X = imread('dog.png');
X = rgb2gray(X);
XX = imnoise(X,'gaussian');

figure
subplot(121),imshow(X),title('原图像');
subplot(122),imshow(XX),title('高斯噪声图像');

figure
[ca1,chd1,cvd1,cdd1] = dwt2(X,'bior3.7');   %进行单层小波分解
set(0,'defaultFigurePosition',[100,100,1000,500]); %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])  
                         
subplot(121); 
imshow(uint8(ca1)); %近似系数分量
title('近似分量')
subplot(1,2,2); 
imshow(chd1);   %细节系数的水平分量
title('细节水平分量')
figure
subplot(121);   
imshow(cvd1);   %细节系数的垂直分量
title('细节垂直分量')
subplot(122); 
imshow(cdd1);    %细节系数的对角分量
title('细节对角分量') 



X = imread('D:\桌面\dog.png');
XX = imnoise(X,'gaussian');
[c,l]=wavedec2(XX,2,'sym4'); %对图像进行清噪处理，用sym4小波函数对x进行两层分解
a2=wrcoef2('a',c,l,'sym4',2);  %重构第二层图像的近似系数
n=[1,2];                              %设置尺度向量
p=[10.28,24.08];                  %设置阈值向量
nc=wthcoef2('t',c,l,n,p,'s');   %对高频小波系数进行阈值处理
mc=wthcoef2('t',nc,l,n,p,'s');  %再次对高频小波系数进行阈值处理
X2=waverec2(mc,l,'sym4');   %图像的二维小波重构
set(0,'defaultFigurePosition',[100,100,1000,500]); %修改图形图像的默认设置
set(0,'defaultFigureColor',[1 1 1])    %修改图形背景颜色的设置     
figure


subplot(121),image(XX),axis square;   %显示含噪声的图像
title('含噪声的图像')
subplot(122),image(a2),axis square;     %显示小波分解去噪后的图像
title('小波分解去噪')




