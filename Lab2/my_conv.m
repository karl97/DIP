function I = my_conv(image,filter)
[fm,fn]=size(filter);%getting the dimensions of the filter
[m,n]=size(image);%getting the dimensions of the image
I=zeros(m,n);%starting value of the sum
%making sure they are of the same type
I=im2double(I);
image=im2double(image);

%The first two loops goes through all pixels, and makes sure the filter is
%not going outside of the image. The second two loops goes through the
%filter and applies it to the current region of the image.
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

