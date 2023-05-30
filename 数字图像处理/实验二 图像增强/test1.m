I=imread('hushan.jpg');
I=rgb2gray(I);      %彩色转灰度图
out=imgrayscaling(I,10,100,5,200);  %将10到100灰度拉伸到5到200灰度范围
imshowpair(I,out,'montage'),axis off;   %对比显示增强前后图
figure;
subplot(1,2,1),imhist(I,64);
subplot(1,2,2),imhist(out,64);