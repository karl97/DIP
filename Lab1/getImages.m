function images = getImages(max)
indexes=randperm(800,max);%randomly selecting max images
%getting the images and converting them to grey-scale
for i=1:max
    if(indexes(1,i)<10)
        images(i,1) = {rgb2gray(imread(strcat('airplanes/image_000',int2str(indexes(1,i)),'.jpg')))};
    elseif(indexes(1,i)<100)
        images(i,1) = {rgb2gray(imread(strcat('airplanes/image_00',int2str(indexes(1,i)),'.jpg')))};
    else
        images(i,1) = {rgb2gray(imread(strcat('airplanes/image_0',int2str(indexes(1,i)),'.jpg')))};
    end
end
end

