function I = glq(I,grayLvls)
[m,n]=size(I);%get the dimensions to be able to go through each pixel
lvls=linspace(0,256,grayLvls);%dividing the 256 interval to reduced size


for i=1:m
    for j=1:n
        step=0;%variable for steps in the new intervall
        newval=0;%variable for storing new pixel value
        for k=1:grayLvls
            if(I(i,j)>step)
                newval=lvls(k);%going through the intervall and finding the new pixel value
            end
            step=step+256/grayLvls;%stepping through the intervall
        end
        I(i,j)=newval;%replacing the new value in the image
    end
end

end

