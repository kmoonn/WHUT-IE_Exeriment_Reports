I2=imread('hushan.jpg');
I2=imnoise(I2,'gaussian',0,0.02);%添加高斯噪声
imshow(I2);
J2=imfilter(I2,fspecial('average',3));%3*3模板滤波
figure,imshow(J2,[]);
J3=imfilter(I2,fspecial('average',7));%7*7模板滤波
figure,imshow(J3,[]);