function [mu,median_,sigma] = bin_area_stats(bin)
nr_blobs=max(bwlabel(bin),[],'all');
blobs=bwlabel(bin);
blob_areas=zeros(1,nr_blobs);
for i=1:nr_blobs
    blob=blobs==i;
    %figure;imshow(blob);
    blob_areas(1,i)=sum(double(blob),'all');
end
mu=mean(blob_areas,'all');
median_=median(blob_areas,'all');
sigma=std(blob_areas,[],'all');
end

