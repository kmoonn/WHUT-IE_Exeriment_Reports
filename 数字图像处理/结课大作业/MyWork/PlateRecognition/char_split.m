function image=char_split(bw) 
[~,x] = size(bw);
bw(:,x)=1;
bw(:,1)=1;
a = sum(~bw);
figure('Name','投影'),bar(a),title('投影');
j = 1;
m =0;
for i = 1:x-1
    if a(i)==0&&a(i+1)~=0
        j = i;
    end
    if a(i)~=0&&a(i+1)==0
        kk=i;
    else
        kk =0;
    end
    if kk~=0
        m = m+1;
        p(m) = j;
        q(m) = kk;
    end    
end
for i = 1:m
    if p(i)<fix(x/8)
    p(i)=p(1);
    end
end
k =1;
for i = 1:m
    if (q(i) - p(i))>(fix(x/10))
        gg(k) = q(i);
        ggg(k) = p(i);
        k = k+1;
    end
end
    
figure('Name','字符分割'),
k =1;
p = zeros(110,55);
image = {p p p p p p p};
for ii = 1:7
    p = imresize(bw(:,ggg(ii):gg(ii)), [110 55],'bilinear');
    image(ii) = mat2cell(p,110,55);
    %image(ii) = p;
    obj = subplot(1,7,ii);
    imshow(p),title(obj,ii);
    pause(0.1);
    k = k +1;
end