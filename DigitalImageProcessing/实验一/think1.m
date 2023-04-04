A=zeros(128,128);
A(61:68,61:68)=255;
imshow(A);
figure;
B=fftshift(fft2(A));
imshow(log(abs(B)),[]),colormap(jet(64)),colorbar;