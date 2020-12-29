function [mu,median_,sigma] = bin_min_axis_stats(bin)
nr_blobs=max(bwlabel(bin),[],'all');
blobs=bwlabel(bin);
blob_ax=zeros(1,nr_blobs);
for i=1:nr_blobs
    blob=blobs==i;
    ax=regionprops(blob,'MinorAxisLength');
    blob_ax(1,i)=ax.MinorAxisLength;
end
mu=mean(blob_ax,'all');
median_=median(blob_ax,'all');
sigma=std(blob_ax,[],'all');
end

