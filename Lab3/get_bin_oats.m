function fil = get_bin_oats(I,oats,rul)
I=medfilt2(I,[10,10]); %apply median filter to reduce noise but keep shapes

%getting graient image and removing the lowest 10%
gmag = imgradient(I);
gmag=double(gmag>0.1);

%filling all holes in the image to find objects
I=imfill(gmag);

%doing watershed with "disk" size oats to get all objects
oats_and_ruler=get_bin_mask(I,oats);
%doing watershed with "disk" size rul to get label and ruler
ruler=get_bin_mask(I,rul);
%getting only the oats
rm_ruler=1-ruler;
fil=oats_and_ruler.*rm_ruler;
end

