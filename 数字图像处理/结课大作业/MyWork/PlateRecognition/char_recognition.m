function bb =char_recognition(image)
liccode=char(['0':'9' 'A':'Z' '贵桂京鲁陕苏渝豫粤']); %建立自动识别字符代码表 
for ii=1:7
    tu = double(cell2mat(image(ii)));
    if ii==1                 %第一位汉字识别
        kmin=37;
        kmax=45;
    elseif ii==2             %第二位 A~Z 字母识别
        kmin=11;
        kmax=36;
    elseif ii>=3
        kmin=1;
        kmax=36; 
    end
     k = 1;
    for k1 = kmin:kmax
        k2 = k1-kmin+1;
        fname=strcat('字符模板\',liccode(k1),'.bmp');
        picture = imread(fname);
        bw(:,:,k2) = imresize(im2bw(picture,graythresh(rgb2gray(picture))),[110 55],'bilinear');
        [y,x,~]=size(tu);
        sum =0;
        for i=1:y
            for j=1:x
                if  tu(i,j)==bw(i,j,k2)%统计黑白
                    sum=sum+1;
                end
            end
        end
        baifenbi(1,k)=sum/(160*55);
        k = k+1;
    end
    chepai= find(baifenbi>=max(baifenbi));
    jj =kmin+chepai-1;
    bb(ii) =' ';
    bb(ii)  = liccode(jj);
end
figure('Name','车牌号码'),title (['识别车牌号码:', bb],'Color','r');