function I = my_bil(image,sigmaS,sigmaR,kSize)
[m,n]=size(image);%getting the dimensions of the image
I=zeros(m,n);
I=im2double(I);
image=im2double(image);
w=zeros(m,n);
for x=1+kSize:m-kSize
    for y=1+kSize:n-kSize        
         for i=x-kSize:x+kSize
             for j=y-kSize:y+kSize
                 range=sqrt((x-i)^2+(y-j)^2);
                 intensity=abs(image(x,y)-image(i,j));
                 w(x,y)=w(x,y)+normpdf(range,0,sigmaS)*normpdf(intensity,0,sigmaR);
                 I(x,y)=I(x,y)+normpdf(range,0,sigmaS)*normpdf(intensity,0,sigmaR)*image(i,j);
             end
         end
      I(x,y)=I(x,y)/w(x,y);
    end
end

end
