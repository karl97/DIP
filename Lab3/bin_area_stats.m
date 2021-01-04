function [mu,median_,sigma] = bin_area_stats(bin)
nr_blobs=max(bwlabel(bin),[],'all');%get nr of blobs for loop
%get all blobs
blobs=bwlabel(bin);
blob_areas=zeros(1,nr_blobs);

%go through all blobs seperately
for i=1:nr_blobs
    blob=blobs==i;
    blob_areas(1,i)=sum(double(blob),'all');
end
%get mu median and sigma
mu=mean(blob_areas,'all');
median_=median(blob_areas,'all');
sigma=std(blob_areas,[],'all');
end

