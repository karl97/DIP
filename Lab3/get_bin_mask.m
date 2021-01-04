function bw = get_bin_mask(I,size)
%create disk objects of size size
se = strel('disk',size);

%erode and reconstruct image
Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);

%dilate and reconstruct to get final image
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

bw = imbinarize(Iobrcbr);

end

