I1=imread('hushan.jpg');
I1=rgb2gray(I1);
imshow(I1);
I2=imnoise(I1,'gaussian',0,0.02);
figure,imshow(I2);
g=fft2(80);
g=fftshift(g);
[N1,N2]=size(g);
n=2;
d0=80;
n1=floor(N1/2);
n2=floor(N2/2);
for i=1:N1
    for j=1:N2
        d=sqrt((i-n1)^2+(j-n2)^2);
        h=1/(1+(d/d0)^(2*n));
        result(i,j)=h*g(i,j);
    end
end
result=ifftshift(result);
X2=ifft2(result);
X3=real(X2);
figure,imshow(X3,[]);