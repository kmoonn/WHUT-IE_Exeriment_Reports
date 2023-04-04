RGB=imread('hushan.bmp');
GRAY=rgb2gray(RGB);
imshow(GRAY);
figure;
D=fftshift(fft2(GRAY));
imshow(log(abs(D)),[]),colormap(jet(64)),colorbar;