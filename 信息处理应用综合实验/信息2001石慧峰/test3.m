I = imread('dog.png');
I = rgb2gray(I);
figure;
subplot(221)
imshow(I),title('原始图像');
I_noise = imnoise(I,'gaussian');
subplot(222)
imshow(I_noise),title('高斯噪声图像')

subplot(223)
F = fft2(I);
F = fftshift(F);
F=log(abs(F)+1);
imshow(F,[]),title('原始图像频谱');

subplot(224)
F_noise = fft2(I_noise);
F_noise = fftshift(F_noise);
F_noise=log(abs(F_noise)+1);
imshow(F_noise,[]),title('高斯噪声图像频谱')


figure
I_denoise = medfilt2(I_noise,[3,3]);
subplot(221)
imshow(I_noise),title('高斯噪声图像')
subplot(222)
imshow(I_denoise),title('中值滤波图像')
subplot(223)
imshow(F_noise,[]),title('高斯噪声图像频谱')
subplot(224)
f =log(abs(fftshift(fft2(I_denoise)))+1);
imshow(f,[]),title('中值滤波图像频谱')

fftImage = F_noise;
% 高斯滤波
sigma = 1.2; % 高斯核的标准差，控制滤波器的广度
filteredImage = imgaussfilt(I_noise, sigma);
F = fftshift(fft2(filteredImage));



% 显示结果
figure;
subplot(2, 2, 1), imshow(I_noise), title('高斯加噪图像');
subplot(2, 2, 2), imshow(filteredImage), title('低通滤波处理后的图像');
subplot(2,2,3),imshow(F_noise,[]),title('高斯噪声图像频谱')
subplot(2,2,4),imshow(log(abs(F)+1),[]),title('低通滤波频谱')

[c,s]=wavedec2(I_noise,2,'sym5');%使用小波sym5，对图像进行二层分解
[THR,SORH,KEEPAPP]=ddencmp('den','wv',I_noise);%计算去噪的默认阈值等
[X_denoise,CXC,LXC,PERF0,PERFL2]=wdencmp('gbl',c,s,'sym5',2,THR,SORH,KEEPAPP);
subplot(2,2,[3,4]);image(X_denoise);title('去噪后的图像Xnoise');axis square;

