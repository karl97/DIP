function [I,sim] = findIm(images,I,histSize)
[m,n]=size(images);
histogramsDiff=zeros(m,1);%saving the magnitude of the difference in histograms
cFind=imhist(I,histSize)/histSize;%normalized histogram to find

%creating all histograms
for i=1:m
    c=imhist(images{i,1},histSize)/histSize;
    histogramsDiff(i,1)=norm(cFind-c);%calculating the difference
end

sim=histogramsDiff;%saving all similarities to the wanted image

m=min(histogramsDiff);%finding the lowest difference between histograms
bestMatch=find(histogramsDiff==m);%getting the image index from the set
I=images{bestMatch,1};%getting the image from the set
end

