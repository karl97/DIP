%% 1.1
clear 
clc
I=imread('clown.tif');
gauss_mask =[0.0625 0.125 0.0625; 0.125 0.25 0.125; 0.0625 0.125, 0.0625];

g=my_conv(I,gauss_mask);%applying a gaussian filter with my convolution function
g2=imfilter(I,gauss_mask,'conv');%applying the same filter with imfilter

figure;
subplot(1,3,1);imshow(g);title('my\_conv');%plotting my_conv result
subplot(1,3,2);imshow(g2);title('imfilter');%plotting imfilters result
subplot(1,3,3);imshow(g-im2double(g2));title('the difference');%plotting the difference


%% 1.2
clear 
clc
I=imread('clown.tif');
%creating 3 mean filters of size 3x3, 5x5 & 9x9
mean3=ones(3,3)/9;
mean5=ones(5,5)/25;
mean9=ones(9,9)/81;
%creating 2 gaussian masks
gauss_mask3 = my_gaussian(3);
gauss_mask5 = my_gaussian(5);
%applying the masks
m3=my_conv(I,mean3);
m5=my_conv(I,mean5);
m9=my_conv(I,mean9);
g3=my_conv(I,gauss_mask3);
g5=my_conv(I,gauss_mask5);
%plotting all the results
figure;
subplot(3, 3, 1); imshow(I); title('OG image');
subplot(3, 3, 2); imshow(m3); title('mean 3x3');
subplot(3, 3, 3); imshow(m5); title('mean 5x5');
subplot(3, 3, 4); imshow(m9); title('mean 9x9');
subplot(3, 3, 5); imshow(g3); title('gaussian 3x3');
subplot(3, 3, 6); imshow(g5); title('gaussian 5x5');

%% 1.3
clear 
clc

I=imread('clown.tif');
%creating the sobel filters for horizontal and vertical edges
sobelx=[1 0 -1; 2 0 -2; 1 0 -1];
sobely=sobelx';
%appling the sobel filters
Gx=my_conv(I,sobelx);
Gy=my_conv(I,sobely);
%plotting the results, and also the |Gx|+|Gy|
figure;
subplot(2,3,1);imshow(I);title('OG image');
subplot(2,3,2);imshow(abs(Gx));title('3x3 sobel Gx');
subplot(2,3,3);imshow(abs(Gy));title('3x3 sobel Gy');
subplot(2,3,4);imshow(abs(Gx)+abs(Gy));title('3x3 sobel Gx+Gy');

%doing the same thing as above but with the laplace filter instead
laplace=[1 1 1; 1 -8 1; 1 1 1];
lap=my_conv(I,laplace);
subplot(2,3,5);imshow(lap);title('3x3 laplace filtered image');


%% 2

clear
clc
Ic=imread('clown.tif');
Ib=imread('boat.tif');
%doing the bilateral filter on the clown image
Ic1 = my_bil(Ic,2,0.1,5);
Ic2 = my_bil(Ic,2,0.25,5);
Ic3 = my_bil(Ic,2,10000,5);
Ic4 = my_bil(Ic,6,0.1,5);
Ic5 = my_bil(Ic,6,0.25,5);
Ic6 = my_bil(Ic,6,10000,5);
%plotting the results with corresponding parameter values
figure;
subplot(2,3,1);imshow(Ic1);title('Sigma_r=0.1, Sigma_s=2');
subplot(2,3,2);imshow(Ic2);title('Sigma_r=0.25, Sigma_s=2');
subplot(2,3,3);imshow(Ic3);title('Sigma_r=Inf, Sigma_s=2');
subplot(2,3,4);imshow(Ic4);title('Sigma_r=0.1, Sigma_s=6');
subplot(2,3,5);imshow(Ic5);title('Sigma_r=0.25, Sigma_s=6');
subplot(2,3,6);imshow(Ic6);title('Sigma_r=Inf, Sigma_s=6');

%doing the bilateral filter on the boat image
Ib1 = my_bil(Ib,2,0.1,5);
Ib2 = my_bil(Ib,2,0.25,5);
Ib3 = my_bil(Ib,2,10000,5);
Ib4 = my_bil(Ib,6,0.1,5);
Ib5 = my_bil(Ib,6,0.25,5);
Ib6 = my_bil(Ib,6,10000,5);
%plotting the results with corresponding parameter values
figure;
subplot(2,3,1);imshow(Ib1);title('Sigma_r=0.1, Sigma_s=2');
subplot(2,3,2);imshow(Ib2);title('Sigma_r=0.25, Sigma_s=2');
subplot(2,3,3);imshow(Ib3);title('Sigma_r=Inf, Sigma_s=2');
subplot(2,3,4);imshow(Ib4);title('Sigma_r=0.1, Sigma_s=6');
subplot(2,3,5);imshow(Ib5);title('Sigma_r=0.25, Sigma_s=6');
subplot(2,3,6);imshow(Ib6);title('Sigma_r=Inf, Sigma_s=6');

%% 3
clear
clc
I=imread('clown.tif');
%testing to go to the frequency domain
I=fft2(I);
I=fftshift(I);
imshow(log(1+abs(I)),[]);%showing the magnitude plot

%% 3.1
clear
clc
I=imread('mandrill.tif');
I=rgb2gray(I);
I=im2double(I);
%going to the frequency domain
If=fft(I);
Ifs=fftshift(If);
%calculating the angles and magnitudes
mag=abs(Ifs);
ang=angle(Ifs);
%plotting the angle and magnitude
subplot(1,2,1);imagesc(log(1+mag));colormap(gray);title('magnitude');
subplot(1,2,2);imagesc(ang);colormap(gray);title('phase');

%% 3.2 
%Eulers formula
%these formulas can be obtained through the graphical intrepertation of
%phase and magnitude
%im=sin(phase)*magnitude
%re=cos(phase)*magnitude
clear 
clc
%getting the angle and magnitude of the mandrill
Im=imread('mandrill.tif');
Im=rgb2gray(Im);
Im=im2double(Im);
Imf=fft(Im);
Imf=fftshift(Imf);
magm=abs(Imf);
angm=angle(Imf);
%getting the angle and magnitude of the clown
Ic=imread('clown.tif');
Ic=im2double(Ic);
Icf=fft(Ic);
Icf=fftshift(Icf);
magc=abs(Icf);
angc=angle(Icf);
%plotting all the data before switching
subplot(2,4,1);imagesc(log(1+magm));colormap(gray);title('mandrill magnitude before');
subplot(2,4,2);imagesc(angm);colormap(gray);title('mandrill phase before');
subplot(2,4,3);imagesc(log(1+magc));colormap(gray);title('clown magnitude before');
subplot(2,4,4);imagesc(angc);colormap(gray);title('clown phase before');

Inewm=sin(angc).*magm*1i+cos(angc).*magm;%calculating the new frequency domain image for the mandrill with the clown phase
Inewc=sin(angm).*magc*1i+cos(angm).*magc;%calculating the new frequency domain image for the clown with the mandrill phase

%extracting the angles and phases for both images
magm=abs(Inewm);
angm=angle(Inewm);
magc=abs(Inewc);
angc=angle(Inewc);
%plotting the current phases and magnitudes
subplot(2,4,5);imagesc(log(1+magm));colormap(gray);title('mandrill magnitude after');
subplot(2,4,6);imagesc(angm);colormap(gray);title('mandrill phase after');
subplot(2,4,7);imagesc(log(1+magc));colormap(gray);title('clown magnitude after');
subplot(2,4,8);imagesc(angc);colormap(gray);title('clown phase after');
%going back to the spatial domain
Inewm=ifftshift(Inewm);
Inewc=ifftshift(Inewc);
Inewm=real(ifft2(Inewm));
Inewc=real(ifft2(Inewc));
%plotting the spatial domain images with switched phases
figure
subplot(2,2,1);imshow(Im);title('mandrill before');
subplot(2,2,2);imshow(Ic);title('clown before');
subplot(2,2,3);imshow(Inewm,[]);title('mandrill after');
subplot(2,2,4);imshow(Inewc,[]);title('clown after');

%% 4.1
clear
clc

I=imread('pattern.tif');
I=im2double(I);
If=fft2(I);
Ifs=fftshift(If);
subplot(1,2,1);imshow(log(1+abs(Ifs)),[]);title('frequency domain image');
mag=abs(Ifs);
f=mag>100;%only show some magnitudes of certain strength for pattern detection
mag=mag.*f;
subplot(1,2,2);imagesc(log(1+mag));colormap(gray);title('strong magnitudes of image');

A=ones(256,256);%initialization of filter

r=10;%radius of notch filter
%parameters for the loop to add the notch filter to the repetetive pattern
spacing=13;
offset=-1;
ind=[0,1,2,3,4,5,6,7,8,9];%indexes of places on the axis that I choose to add the filter to(in this case all, but useful if change is needed)
[m,n]=size(ind);
for i=1:n
    A=A.*notch(Ifs,r,129,offset+spacing*ind(i)+1).*notch(Ifs,r,offset+spacing*ind(i)+1,129);%creating the combined filter
end

figure;mesh(A);%plot the filter
If2=Ifs.*A;%apply the filter
figure;subplot(1,3,1);imshow(log(1+abs(If2)),[]);title('applied filter');%plot the frequency domain with applied filter
If2=ifftshift(If2);
I2=real(ifft2(If2));
subplot(1,3,2);imshow(I2,[]);title('filtered image');%show the filtered image in spatial domain
subplot(1,3,3);imshow(I);title('original image');%show the original image in the spatial domain


%% 4.2
clear
clc

I=imread('car_gray_corrupted.png');
I=im2double(I);
If=fft2(I);
Ifs=fftshift(If);
%showing the unfiltered frequency doimain image
subplot(1,2,1);imshow(log(1+abs(Ifs)),[]);title('frequency domain image');

A=ones(512,512);%initializing filter
r=1;%choosing only 1 pixel since in the frequency domain image that the relevant frequencie ares are of 1 pixel in size
A=A.*notch(Ifs,r,326,296).*notch(Ifs,r,328,298).*notch(Ifs,r,266,356).*notch(Ifs,r,268,358);%applying the filter to the places in the frequency image where the frequencies should be removed

If2=Ifs.*A;%apply filter
subplot(1,2,2);imshow(log(1+abs(If2)),[]);title('applied filter');%show the filtered frequency image

%go back to the spatial domain to display results
If2=ifftshift(If2);
I2=real(ifft2(If2));
%viewing the results
figure;subplot(1,2,1);imshow(I);title('original image');
subplot(1,2,2);imshow(I2,[]);title('filtered image');

%% just to dispay the images for the report
subplot(2,3,1);imshow(imread('clown.tif'));title('clown');
subplot(2,3,2);imshow(imread('boat.tif'));title('boat');
subplot(2,3,3);imshow(rgb2gray(imread('mandrill.tif')));title('mandrill');
subplot(2,3,4);imshow(imread('pattern.tif'));title('pattern');
subplot(2,3,5);imshow(imread('car_gray_corrupted.png'));title('car\_gray\_corrupted');