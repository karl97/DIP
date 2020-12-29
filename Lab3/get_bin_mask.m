function bw = get_bin_mask(I,size)

se = strel('disk',size);

Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);

Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

bw = imbinarize(Iobrcbr);

end

