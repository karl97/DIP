%% 1

I = imread('mandrill.tif'); %read the mandrill image
I = rgb2gray(I); %convert it to grey-scale
row8 = I(8,:); row64 = I(64,:); row128 = I(128,:); %get rows 8, 64 and 128 from the image

figure;
subplot(4, 1, 1); imshow(I); title('Image'); axis image tight on; %plot the grey-scale image
subplot(4, 1, 2); plot(row8); title('Row 8'); axis tight;%plot row 8
subplot(4, 1, 3); plot(row64); title('Row 64'); axis tight;%plot row 64
subplot(4, 1, 4); plot(row128); title('Row 128'); axis tight;%plot row 128

%% 2
clear
I = imread('mandrill.tif');
I = rgb2gray(I);

I=imrotate(I,30);
subplot(1, 2, 1);imshow(I);%show 30 degree rotation
I=imrotate(I,180);
subplot(1, 2, 2);imshow(I);%show 180 degree rotation applied to the 30 degree rotation


I = imread('mandrill.tif');
I1 = rgb2gray(I);%image to rotate 4*90
I2 = rgb2gray(I);%image to rotate 8*45
I3 = rgb2gray(I);%image to rotate 36*10
for i=1:4
    I1=imrotate(I1,90);%rotate 4*90
end

for i=1:8
    I2=imrotate(I2,45);%rotate 8*45
end

for i=1:36
    I3=imrotate(I3,10);%rotate 36*10
end

%plot the resulting 3 images
figure;
subplot(2,2,1);imshow(I1); title('4*90');
subplot(2,2,2);imshow(I2); title('8*45');
subplot(2,2,3);imshow(I3); title('36*10');

%% intermediate steps in 8*45 rot
I = imread('mandrill.tif');
I2 = rgb2gray(I);
%plotting the steps of rotation so we can see whats going on each step
figure;
for i=1:8
    I2=imrotate(I2,45);
    subplot(4,2,i);imshow(I2); title(i);
end

%% 3
clear
I = imread('mandrill.tif');
I = rgb2gray(I);%by default 256 grey-levels
I=glq(I,8);%reduce grey-levels to 8
imshow(I);%display 8 grey-lvl mandrill

%% 4.1
clear
Ic = imread('clown.tif');
Ib = imread('boat.tif');
Ip=imnoise(Ic,'gaussian',0,0.5);%creating a noisy clown with added gaussian noise of mean 0 and std 0.5

%displaying the loaded images and their histograms
subplot(2,3,1); imshow(Ip); title('clown with noise');
subplot(2,3,2); imshow(Ic); title('clown');
subplot(2,3,3); imshow(Ib); title('boat');
subplot(2,3,4); imhist(Ip,256); title('clown with noise hist');
subplot(2,3,5); imhist(Ic,256); title('clown hist');
subplot(2,3,6); imhist(Ib,256); title('boat hist');

%getting the stats for the images
Ip=imStat(Ip);
Ic=imStat(Ic);
Ib=imStat(Ib);

%displaying the stats
figure;
subplot(2,3,1); imshow(Ip); title('clown with noise');
subplot(2,3,2); imshow(Ic); title('clown');
subplot(2,3,3); imshow(Ib); title('boat');
subplot(2,3,4); imhist(Ip,256); title('clown with noise hist');
subplot(2,3,5); imhist(Ic,256); title('clown hist');
subplot(2,3,6); imhist(Ib,256); title('boat hist');

%% 4.2
clear
images=getImages(20);%getting 20 random grey-scale images of planes (can maximum get 800) 
Im=imnoise(images{1,1},'gaussian',0,0.0);%change the last parameter if we wanna search with noise
[I,sim]=findIm(images,Im,256);%find the most similar image to Im in images using 256 scale histograms. The output I is most similar and sim is the relation between all images in the set

%display the wanted image and resulting image
figure;
subplot(2,1,1);imshow(Im);title('find mot similar to this');
subplot(2,1,2);imshow(I);title('most similar');

%% 4.3
clear
images=getImages(200);
images1=images(1:150);%training data
images2=images(151:end);%test data
%addimg two special images to the test set
images2(49,1)={imnoise(imread('clown.tif'),'gaussian',0,1)};
images2(50,1)={imnoise(imread('boat.tif'),'gaussian',0,1)};

sim=getSimMatrix(images1);%get all the similarities in the training set
t=getThreshold(sim)%get the threshold of two standard deviations of the training set

%display the training set and the threshold as an intersecting plane
figure;
surf(sim);
hold on;
[m,n]=size(sim);
surf(ones(m,n)*t);

sim=getSimMatrix(images2);%get all the similarities in the test set

%display the test set and the threshold obtained in training as an
%intersecting plane
figure;
surf(sim);
hold on;
[m,n]=size(sim);
surf(ones(m,n)*t);

specialIm=classifySpecialImages(images2,0.90,t);%getting all the special images in the test set.(special image = 90% of the similarities outside the threshold)
[a,b]=size(specialIm);
%displaying all the images classified as special images
figure
for i=1:a
    subplot(a,1,i);imshow(specialIm{i,1});
end


