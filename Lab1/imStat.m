function J = imStat(I)
[m,n]=size(I);%getting the dimensions of the image
J=I;%new image to store the stats in

%doing the stats on a smaller image, -1 pixel in the edges, so that the
%edge pixels can find neighbours
for i=2:m-1
    for j=2:n-1
        %taking the center pixel and subtracting the mean of the 8-neighbours
        J(i,j)=abs(double(I(i,j))-(1/8)*(double(I(i-1,j-1))+double(I(i-1,j))+double(I(i-1,j+1))+double(I(i,j-1))+double(I(i,j+1))+double(I(i+1,j-1))+double(I(i+1,j))+double(I(i+1,j+1))));;
    end
end
end

