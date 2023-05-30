function bw = image_clip(picture_6) %裁剪图片的函数
threshold =30 ;
picture_7=touying(picture_6);
picture_8=~picture_7;
picture_9 = bwareaopen(picture_8, threshold);%删除二值图像BW中面积小于P的对象，这里的值是50
picture_10=~picture_9;
[~,~]=size(picture_10);%对长宽重新赋值 %1为白色
bw = picture_10;
[~,x] = size(bw);
dd = fix(x/40);
ddd = fix(x/30);
dd = x - dd;
bw = bw(:,ddd:dd);
figure('Name','边框去除'),imshow(bw),title('边框去除');  