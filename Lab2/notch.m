function filter = notch(image,sizef,posX,posY)
[m,n]=size(image);%getting the size of the image for the filter
filter=ones(m,n);%starting with a filter of ones, everything passes
%Calculating the mirrored points from the center of the filter, since it is
%centered even dimenions give +1 for index and +1 for adding the "center
%row/column"

%values for uneven dimensions
pos2X=m-posX+1;
pos2Y=n-posY+1;
if(mod(m,2)==0)%if m is even
    pos2X=m-posX+2;
end
if(mod(n,2)==0)%if n is even
pos2Y=n-posY+2;
end
%getting the std for the gaussian from the size of the notch filter
sigma=sizef/2;
%create zeros at points where filter is applied to remove parts
for i=1:m
    for j=1:n
        if((sizef>sqrt((posX-i)^2+(posY-j)^2)))
            filter(i,j)=1-(1/normpdf(0,0,sigma))*normpdf((sqrt((posX-i)^2+(posY-j)^2)),0,sigma);%use this if no gaussian zeros(1);
        end
        if(sizef>sqrt((pos2X-i)^2+(pos2Y-j)^2))%Circular form of the parts to filter away
            filter(i,j)=1-(1/normpdf(0,0,sigma))*normpdf((sqrt((pos2X-i)^2+(pos2Y-j)^2)),0,sigma);%use this if no gaussian zeros(1);
        end
    end
end

end

