function simM = getSimMatrix(images)
[m,n]=size(images);%getting the dimensions
simM=zeros(m,m);

%going through all the images
for i=1:m
    [I,sim]=findIm(images,images{i,1},256);%sim is a vector of similarities
    simM(i,:)=sim;%saving all the similarities between images in matrix form
end
end

