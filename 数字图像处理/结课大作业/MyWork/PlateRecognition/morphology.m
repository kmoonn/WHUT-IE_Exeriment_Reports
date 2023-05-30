function picture_6 = morphology(picture_1)
threshold = 50;
picture_2 = im2bw(picture_1,graythresh(picture_1)); 
%最大类间方差法 是一种基于全局的二值化算法，它是根据图像的灰度特性,将图像分为前景和背景两个部分
%将灰度图像 I 转换为二值图像 BW，方法是将输入图像中亮度大于 level 的所有像素替换为值 1（白色），将所有其他像素替换为值 0（黑色）。

figure('Name','车牌二值化'),imshow(picture_2);
title('二值化');

%对二值图像的形态学操作 移除H连通的像素 inf是指重复操作指导图像不再变化
picture_3 = bwmorph(picture_2,'hbreak',inf); 
%删除杂散像素
picture_4 = bwmorph(picture_3,'spur',inf);
%执行形态学开运算（先腐蚀后膨胀）开运算能够除去孤立的小点，毛刺和小桥，而总的位置和形状不便
picture_5 = bwmorph(picture_4,'open',inf);
% bwareaopen(BW,P) 从二值图像 BW 中删除少于 P 个像素的所有连通分量（对象），并生成另一个二值图像 BW2。此运算称为面积开运算。
picture_6 = bwareaopen(picture_5,threshold);

picture_6 = ~picture_6; %反转

figure('Name','形态学处理'),imshow(picture_6);
title('形态学处理'); 