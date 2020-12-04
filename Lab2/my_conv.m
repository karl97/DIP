function I = my_conv(image,filter)
[fm,fn]=size(filter);
[m,n]=size(image);%getting the dimensions of the image
I=zeros(m,n);
I=im2double(I);
image=im2double(image);

for x=(fm-1)/2+1:m-(fm-1)/2-1
    for y=(fn-1)/2+1:n-(fn-1)/2-1
        for i=1:fm
            for j=1:fn
                I(x,y)=I(x,y)+filter(i,j)*image(x-i+(fm-1)/2+1,y-j+(fn-1)/2+1);
            end
        end
    end
end
end

