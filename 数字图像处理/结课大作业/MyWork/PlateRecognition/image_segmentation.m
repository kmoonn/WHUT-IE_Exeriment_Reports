function bw =image_segmentation(I)  %图像分割
Image = I;              %读取RGB图像
Image=im2double(Image); %双精度类型 便于运算
I=rgb2hsv(Image);       %RGB模型转换hsv模型  色调（H） 饱和度（S） 明度（V）
[y,x,z]=size(I);        %%y x z 返回RGB彩色图像数据矩阵行 列 等
Blue_y = zeros(y, 1);  
p=[0.56 0.71 0.4 1 0.3 1 0];  
for i = 1 : y  
    for j = 1 : x  
        hij = I(i, j, 1);  
        sij = I(i, j, 2);  
        vij = I(i, j, 3);  
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...  
                (vij>=p(5)&&vij<=p(6))  
            Blue_y(i, 1) = Blue_y(i, 1) + 1;  %蓝色象素点统计 
        end  
    end  
end  
[~, MaxY] = max(Blue_y);  %最大值 
Th = p(7);  
PY1 = MaxY;  
while ((Blue_y(PY1,1)>Th) && (PY1>0))  
    PY1 = PY1 - 1;  
end  
PY2 = MaxY;  
while ((Blue_y(PY2,1)>Th) && (PY2<y))  
    PY2 = PY2 + 1;  
end  
PY1 = PY1 - 2;  
PY2 = PY2 + 2;  
if PY1 < 1  
    PY1 = 1;  
end  
if PY2 > y  
    PY2 = y;  
end  
bw=Image(PY1:PY2,:,:); 
IY = I(PY1:PY2, :, :);   
I2=im2bw(IY,0.5);  
  
[y1,x1,z1]=size(IY);  
Blue_x=zeros(1,x1);  
for j = 1 : x1  
    for i = 1 : y1  
        hij = IY(i, j, 1);  
        sij = IY(i, j, 2);  
        vij = IY(i, j, 3);  
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...  
                (vij>=p(5)&&vij<=p(6))  
            Blue_x(1, j) = Blue_x(1, j) + 1;   
%              bw1(i, j) = 1;  
        end  
    end  
end  
PY1;PY2;
  
[~, MaxX] = max(Blue_x);  
Th = p(7);  
PX1 = MaxX;  
  
while ((Blue_x(1,PX1)>Th) && (PX1>0))  
    PX1 = PX1 - 1;  
end  
PX2 = MaxX;  
while ((Blue_x(1,PX2)>Th) && (PX2<x1))  
    PX2 = PX2 + 1;  
end  
Picture=Image(PY1:PY2,PX1:PX2,:);  %对原图片进行剪裁 裁出车牌位置
bw = Picture;
figure('Name','图像分割');imshow(bw);title('车牌图像');
