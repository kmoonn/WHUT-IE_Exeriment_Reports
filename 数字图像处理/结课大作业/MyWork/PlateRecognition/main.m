clc;          %清空命令行
%读入图片
[fn,pn,fi] = uigetfile('*.jpg','选择图片');

I = imread([pn fn]);                %读入彩色图像
figure('Name','原始图像');
imshow(I);
title('原始图像');        %显示原始图像

%图像分割(车牌定位)
picture =image_segmentation(I);
threshold=50;

%倾斜校正
[picture_1,angle] = rando_bianhuan(picture); 
% picture 返回校正后的图片
% angle 返回倾斜角度

%形态学处理
picture_6 = morphology(picture_1);

%对图像进一步裁剪
bw = image_clip(picture_6);

%文字分割
image=char_split(bw);

%显示字符分割结果
bb =char_recognition(image);

%显示车牌识别结果
imshow(picture_1);
title (['识别车牌号码:', bb],'Color','r');
