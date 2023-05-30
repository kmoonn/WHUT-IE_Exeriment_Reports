% 读取 RGB 彩色图像
rgb_image = imread('demo.png');

% 转换为灰度图像
gray_image = rgb2gray(rgb_image);

% 显示原图和灰度图像
subplot(1, 2, 1), imshow(rgb_image), title('RGB Image');
subplot(1, 2, 2), imshow(gray_image), title('Gray Image');