function [picture,angle] = rando_bianhuan(bw) %倾斜校正  
% picture 返回校正后的图片 angle倾斜角度

I=rgb2gray(bw);
%rgb2gray 函数通过消除色调和饱和度信息，同时保留亮度 将RGB图像转换为灰度图。
I=edge(I); %返回二值图像 BW，其中的值 1 对应于灰度或二值图像 I 中函数找到边缘的位置，值 0 对应于其他位置
theta = 1:180;
[R,~] = radon(I,theta); %返回基于 theta 所指定角度的 Radon 变换。
[~,J] = find(R>=max(max(R)));  %J记录了倾斜角
angle=90-J;
picture=imrotate(bw,angle,'bilinear','crop'); %返回旋转后的图像矩阵。正数表示逆时针旋转 负数表示顺时针旋转。
figure('Name','倾斜校正图像');
imshow(picture);title('倾斜校正');
imwrite(picture,'倾斜校正车牌.jpg');