%% 1.1
clc
clear

I = imread('recognition/query/QueryImage1.jpg');
I = rgb2gray(I);
pts = detectSURFFeatures(I);
%pts = detectSURFFeatures(I,'MetricThreshold',1000.0,'NumOctaves',3,'NumScaleLevels',6);%increase scale levels
%pts = detectSURFFeatures(I,'MetricThreshold',1000.0,'NumOctaves',4,'NumScaleLevels',4);%detect larger blobs
figure;imshow(I); hold on;
plot(pts.selectStrongest(50)); hold off;


%% 1.2

[feats,validPts] = extractFeatures(I,pts);
figure;imshow(I); hold on;
%plot 50 strongest valid  pts
plot(validPts.selectStrongest(50)); hold off;

%% 1.3
clc
clear

I = imread('graffiti_images/graffiti1.png');
Ig = rgb2gray(I);
pts = detectSURFFeatures(Ig);
[feats1,validPts1] = extractFeatures(Ig,pts);

I2 = imread('graffiti_images/graffiti3.png');
I2g = rgb2gray(I2);
pts2 = detectSURFFeatures(I2g);
[feats2,validPts2] = extractFeatures(I2g,pts2);

%match features and display the connections
%indexPairs = matchFeatures(feats1,feats2); %default config
indexPairs = matchFeatures(feats1,feats2,'MatchThreshold',10,'MaxRatio',0.3); %optimal config
matchedPoints1 = validPts1(indexPairs(:, 1));
matchedPoints2 = validPts2(indexPairs(:, 2));
showMatchedFeatures(I,I2,matchedPoints1,matchedPoints2,'montage')


%% 1.4
clc
clear
%find matching images for all query images
for i=1:20
    recognition(i);
end
%% 2.1
%will search the folders for files and extract information based on what
%the names contain, function called load_oats. huv=1,grn=2.
%fat=1, bel=2, symp=3. got=1, lan=2, mul=3.
clc
clear
images=load_oats();

%% no clear of variables so we dont need to load all images again
% 2.2 a) 

%init of data
nroat=zeros(1,length(images));
Ibins = cell(1,66);

%getting the binary mask for all images
for i=1:length(images)
    I=im2double(rgb2gray(images{i}.image));
    Ibins(i)={get_bin_oats(I,6,55)}; %get bin mask
    %figure;imshow((1-Ibins{i}).*I); %visualization
    nroat(1,i)=max(bwlabel(Ibins{i}),[],'all'); %gettng nr of oats in image
end
%max and min nr oats in image
maximim=max(nroat,[],'all');
minimum=min(nroat,[],'all');

%% 2.3
figure;imshow(rgb2gray(images{1}.image));
figure;subplot(1,2,1);imshow(Ibins{1});
subplot(1,2,2);imshow(Ibins{12});

[mu,med,sigma]=bin_area_stats(Ibins{1});%huv
[mu2,med2,sigma2]=bin_area_stats(Ibins{12});%grn
figure;subplot(2,3,1);bar(categorical({'mean','median','std'}),[mu,mu2;med,med2;sigma,sigma2]);
title('area');legend('huv','grn');

[mu,med,sigma]=bin_min_axis_stats(Ibins{1})
[mu2,med2,sigma2]=bin_min_axis_stats(Ibins{12})
subplot(2,3,2);bar(categorical({'mean','median','std'}),[mu,mu2;med,med2;sigma,sigma2]);
title('Min Axis');legend('huv','grn');

[mu,med,sigma]=bin_max_axis_stats(Ibins{1});
[mu2,med2,sigma2]=bin_max_axis_stats(Ibins{12});
subplot(2,3,3);bar(categorical({'mean','median','std'}),[mu,mu2;med,med2;sigma,sigma2]);
title('Max Axis');legend('huv','grn');

[mu,med,sigma]=color_stats(Ibins{1},im2double(images{1}.image));
[mu2,med2,sigma2]=color_stats(Ibins{12},im2double(images{12}.image));
subplot(2,3,4);bar(categorical({'mean huv','mean grn','median huv','median grn','std huv','std grn'}),[mu;mu2;med;med2;sigma;sigma2]);
title('RGB');legend('R','G','B');

[mu,med,sigma]=color_stats(Ibins{1},im2double(rgb2hsv(images{1}.image)));
[mu2,med2,sigma2]=color_stats(Ibins{12},im2double(rgb2hsv(images{12}.image)));
subplot(2,3,5);bar(categorical({'mean huv','mean grn','median huv','median grn','std huv','std grn'}),[mu;mu2;med;med2;sigma;sigma2]);
title('HSV');legend('H','S','V');

%% 2.4
% by inspecting the [2016,1512] image 7 pixel heights correspond to 1mm, so
% 1 square mm is an area of 7*7=49 pixels. so to get square mm  from pixel
% area just divide by 49
%imshow(imresize(images{12}.image,[2016,1512]))

stats=get_all_stats(Ibins{1},im2double(images{1}.image));

%% 2.5

for i=1:length(images)
    stats(i)=get_all_stats(Ibins{i},im2double(images{i}.image));
end

%%
%getting the indexes for different plots based on farm,cultivation and
%shoot
for i=1:length(images)
    got_ind(i)=images{i}.farm==1;
    lan_ind(i)=images{i}.farm==2;
    mul_ind(i)=images{i}.farm==3;
    fat_ind(i)=images{i}.cultivation==1;
    bel_ind(i)=images{i}.cultivation==2;
    symp_ind(i)=images{i}.cultivation==3;
    huv_ind(i)=images{i}.type==1;
    grn_ind(i)=images{i}.type==2;
end
%% testing boxplot
got=stats(got_ind);
lan=stats(lan_ind);
mul=stats(mul_ind);

figure;
a=mean([got.average_area]);
b=mean([got.average_major_axis]);
c=mean([got.average_minor_axis]);
a2=mean([lan.average_area]);
b2=mean([lan.average_major_axis]);
c2=mean([lan.average_minor_axis]);
a3=mean([mul.average_area]);
b3=mean([mul.average_major_axis]);
c3=mean([mul.average_minor_axis]);
subplot(2,3,1);bar(categorical({'area'}),[a,a2,a3]);
title('Farms mean');legend('got','lan','mul');
subplot(2,3,2);bar(categorical({'major axis'}),[b,b2,b3]);
title('Farms mean');legend('got','lan','mul');
subplot(2,3,3);bar(categorical({'minor axis'}),[c,c2,c3]);
title('Farms mean');legend('got','lan','mul');

a=std([got.average_area]);
b=std([got.average_major_axis]);
c=std([got.average_minor_axis]);
a2=std([lan.average_area]);
b2=std([lan.average_major_axis]);
c2=std([lan.average_minor_axis]);
a3=std([mul.average_area]);
b3=std([mul.average_major_axis]);
c3=std([mul.average_minor_axis]);
subplot(2,3,4);bar(categorical({'area'}),[a,a2,a3]);
title('Farms std');legend('got','lan','mul');
subplot(2,3,5);bar(categorical({'major axis'}),[b,b2,b3]);
title('Farms std');legend('got','lan','mul');
subplot(2,3,6);bar(categorical({'minor axis'}),[c,c2,c3]);
title('Farms std');legend('got','lan','mul');

figure;
huv=stats(huv_ind);
grn=stats(grn_ind);
a=mean([huv.average_area]);
b=mean([huv.average_major_axis]);
c=mean([huv.average_minor_axis]);
a2=mean([grn.average_area]);
b2=mean([grn.average_major_axis]);
c2=mean([grn.average_minor_axis]);
subplot(2,3,1);bar(categorical({'area'}),[a,a2]);
title('Shoot mean');legend('huv','grn');
subplot(2,3,2);bar(categorical({'major axis'}),[b,b2]);
title('Shoot mean');legend('huv','grn');
subplot(2,3,3);bar(categorical({'minor axis'}),[c,c2]);
title('Shoot mean');legend('huv','grn');

huv=stats(huv_ind);
grn=stats(grn_ind);
a=std([huv.average_area]);
b=std([huv.average_major_axis]);
c=std([huv.average_minor_axis]);
a2=std([grn.average_area]);
b2=std([grn.average_major_axis]);
c2=std([grn.average_minor_axis]);
subplot(2,3,4);bar(categorical({'area'}),[a,a2]);
title('Shoot std');legend('huv','grn');
subplot(2,3,5);bar(categorical({'major axis'}),[b,b2]);
title('Shoot std');legend('huv','grn');
subplot(2,3,6);bar(categorical({'minor axis'}),[c,c2]);
title('Shoot std');legend('huv','grn');

figure;
fat=stats(fat_ind);
bel=stats(bel_ind);
symp=stats(symp_ind);
a=mean([fat.average_area]);
b=mean([fat.average_major_axis]);
c=mean([fat.average_minor_axis]);
a2=mean([bel.average_area]);
b2=mean([bel.average_major_axis]);
c2=mean([bel.average_minor_axis]);
a3=mean([symp.average_area]);
b3=mean([symp.average_major_axis]);
c3=mean([symp.average_minor_axis]);
subplot(2,3,1);bar(categorical({'area'}),[a,a2,a3]);
title('Cult mean');legend('fat','bel','symp');
subplot(2,3,2);bar(categorical({'major axis'}),[b,b2,b3]);
title('Cult mean');legend('fat','bel','symp');
subplot(2,3,3);bar(categorical({'minor axis'}),[c,c2,c3]);
title('Cult mean');legend('fat','bel','symp');

fat=stats(fat_ind);
bel=stats(bel_ind);
symp=stats(symp_ind);
a=std([fat.average_area]);
b=std([fat.average_major_axis]);
c=std([fat.average_minor_axis]);
a2=std([bel.average_area]);
b2=std([bel.average_major_axis]);
c2=std([bel.average_minor_axis]);
a3=std([symp.average_area]);
b3=std([symp.average_major_axis]);
c3=std([symp.average_minor_axis]);
subplot(2,3,4);bar(categorical({'area'}),[a,a2,a3]);
title('Cult std');legend('fat','bel','symp');
subplot(2,3,5);bar(categorical({'major axis'}),[b,b2,b3]);
title('Cult std');legend('fat','bel','symp');
subplot(2,3,6);bar(categorical({'minor axis'}),[c,c2,c3]);
title('Cult std');legend('fat','bel','symp');

%% color stats
figure;
%means
a=mean(reshape([got.average_RGB],[3 length([got.average_RGB])/3])');
a2=mean(reshape([got.average_HSV],[3 length([got.average_HSV])/3])');
b=mean(reshape([lan.average_RGB],[3 length([lan.average_RGB])/3])');
b2=mean(reshape([lan.average_HSV],[3 length([lan.average_HSV])/3])');
c=mean(reshape([mul.average_RGB],[3 length([mul.average_RGB])/3])');
c2=mean(reshape([mul.average_HSV],[3 length([mul.average_HSV])/3])');

subplot(2,3,1);bar(categorical({'RGB got','RGB lan','RGB mul','HSV got','HSV lan','HSV mul'}),[a;b;c;a2;b2;c2]);
title('Farms mean');legend('R/H','G/S','B/V');

a=mean(reshape([huv.average_RGB],[3 length([huv.average_RGB])/3])');
a2=mean(reshape([huv.average_HSV],[3 length([huv.average_HSV])/3])');
b=mean(reshape([grn.average_RGB],[3 length([grn.average_RGB])/3])');
b2=mean(reshape([grn.average_HSV],[3 length([grn.average_HSV])/3])');

subplot(2,3,2);bar(categorical({'RGB huv','RGB grn','HSV huv','HSV grn'}),[a;b;a2;b2]);
title('Shoot mean');legend('R/H','G/S','B/V');


a=mean(reshape([fat.average_RGB],[3 length([fat.average_RGB])/3])');
a2=mean(reshape([fat.average_HSV],[3 length([fat.average_HSV])/3])');
b=mean(reshape([bel.average_RGB],[3 length([bel.average_RGB])/3])');
b2=mean(reshape([bel.average_HSV],[3 length([bel.average_HSV])/3])');
c=mean(reshape([symp.average_RGB],[3 length([symp.average_RGB])/3])');
c2=mean(reshape([symp.average_HSV],[3 length([symp.average_HSV])/3])');

subplot(2,3,3);bar(categorical({'RGB fat','RGB bel','RGB symp','HSV fat','HSV bel','HSV symp'}),[a;b;c;a2;b2;c2]);
title('Cult mean');legend('R/H','G/S','B/V');

%stds
a=std(reshape([got.average_RGB],[3 length([got.average_RGB])/3])');
a2=std(reshape([got.average_HSV],[3 length([got.average_HSV])/3])');
b=std(reshape([lan.average_RGB],[3 length([lan.average_RGB])/3])');
b2=std(reshape([lan.average_HSV],[3 length([lan.average_HSV])/3])');
c=std(reshape([mul.average_RGB],[3 length([mul.average_RGB])/3])');
c2=std(reshape([mul.average_HSV],[3 length([mul.average_HSV])/3])');

subplot(2,3,4);bar(categorical({'RGB got','RGB lan','RGB mul','HSV got','HSV lan','HSV mul'}),[a;b;c;a2;b2;c2]);
title('Farms std');legend('R/H','G/S','B/V');

a=std(reshape([huv.average_RGB],[3 length([huv.average_RGB])/3])');
a2=std(reshape([huv.average_HSV],[3 length([huv.average_HSV])/3])');
b=std(reshape([grn.average_RGB],[3 length([grn.average_RGB])/3])');
b2=std(reshape([grn.average_HSV],[3 length([grn.average_HSV])/3])');

subplot(2,3,5);bar(categorical({'RGB huv','RGB grn','HSV huv','HSV grn'}),[a;b;a2;b2]);
title('Shoot std');legend('R/H','G/S','B/V');

a=std(reshape([fat.average_RGB],[3 length([fat.average_RGB])/3])');
a2=std(reshape([fat.average_HSV],[3 length([fat.average_HSV])/3])');
b=std(reshape([bel.average_RGB],[3 length([bel.average_RGB])/3])');
b2=std(reshape([bel.average_HSV],[3 length([bel.average_HSV])/3])');
c=std(reshape([symp.average_RGB],[3 length([symp.average_RGB])/3])');
c2=std(reshape([symp.average_HSV],[3 length([symp.average_HSV])/3])');

subplot(2,3,6);bar(categorical({'RGB fat','RGB bel','RGB symp','HSV fat','HSV bel','HSV symp'}),[a;b;c;a2;b2;c2]);
title('Cult std');legend('R/H','G/S','B/V');
