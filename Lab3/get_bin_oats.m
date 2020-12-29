function fil = get_bin_oats(I,oats,rul)
I=medfilt2(I,[10,10]);
gmag = imgradient(I);
gmag=double(gmag>0.1);
I=imfill(gmag);
%figure;imshow(I);
oats_and_ruler=get_bin_mask(I,oats);
ruler=get_bin_mask(I,rul);
rm_ruler=1-ruler;
fil=oats_and_ruler.*rm_ruler;
end

