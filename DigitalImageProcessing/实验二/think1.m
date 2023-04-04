img=imread('hushan.jpg');
img=rgb2gray(img);
subplot(121);
imshow(img);
h2 = fspecial('sobel');
g2 = imfilter(img,h2);
subplot(122);
imshow(g2);