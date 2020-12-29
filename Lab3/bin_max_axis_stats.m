function [mu,median_,sigma] = bin_max_axis_stats(bin)
nr_blobs=max(bwlabel(bin),[],'all');
blobs=bwlabel(bin);
blob_ax=zeros(1,nr_blobs);
for i=1:nr_blobs
    blob=blobs==i;
    ax=regionprops(blob,'MajorAxisLength');
    blob_ax(1,i)=ax.MajorAxisLength;
end
mu=mean(blob_ax,'all');
median_=median(blob_ax,'all');
sigma=std(blob_ax,[],'all');
end

