% 读入图像
img = imread('car_gray.png');

% 添加高斯噪声
img_noisy = imnoise(img, 'gaussian', 0, 0.01);

% 均值滤波
h = fspecial('average', 3);
img_average = imfilter(img_noisy, h);

% 显示结果
subplot(1, 3, 1), imshow(img), title('原始图像');
subplot(1, 3, 2), imshow(img_noisy), title('添加噪声后的图像');
subplot(1, 3, 3), imshow(img_average), title('均值滤波后的图像');