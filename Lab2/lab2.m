%% 1.1
clear 
clc
I=imread('clown.tif');
imshow(I)
gauss_mask =[0.0625 0.125 0.0625; 0.125 0.25 0.125; 0.0625 0.125, 0.0625];

g=my_conv(I,gauss_mask);
g2=imfilter(I,gauss_mask,'conv');
figure
imshow(g-im2double(g2));

%% 1.2
clear 
clc
I=imread('clown.tif');
mean3=ones(3,3)/9;
mean5=ones(5,5)/25;
mean9=ones(9,9)/81;
gauss_mask3 = [0.0625 0.125 0.0625; 0.125 0.25 0.125; 0.0625 0.125, 0.0625];
gauss_mask5 = random('normal',0.1,0.06,5,5);
m3=my_conv(I,mean3);
m5=my_conv(I,mean5);
m9=my_conv(I,mean9);
g3=my_conv(I,gauss_mask3);
g5=my_conv(I,gauss_mask5);

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
%I=imrotate(I,-90);
sobelx=[1 0 -1; 2 0 -2; 1 0 -1]
sobely=sobelx'
Gx=my_conv(I,sobelx);
Gy=my_conv(I,sobely);
figure
subplot(2,2,1);imshow(I);title('OG image');
subplot(2,2,2);imshow(abs(Gx));title('sobel Gx');
subplot(2,2,3);imshow(abs(Gy));title('sobel Gy');
subplot(2,2,4);imshow(abs(Gx)+abs(Gy));title('sobel Gx+Gy');

figure
laplace=[1 1 1; 1 -8 1; 1 1 1];
lap=my_conv(I,laplace);
imshow(lap);title('laplace filtered image');


%% 2

clear
clc
I=imread('clown.tif');

I = my_bil(I,10,0.1,5);
%I2=imbilatfilt(I);
imshow(I);
%figure
%imshow(I2);

%% 3
clear
clc
I=imread('clown.tif');
I=fft2(I);
I=fftshift(I);
I=abs(I);
imshow(log(1+I),[])

%% 3.1
clear
clc
I=imread('mandrill.tif');
I=rgb2gray(I);
I=im2double(I);
If=fft(I);
Ifs=fftshift(If);
mag=abs(Ifs);
ang=angle(Ifs);
subplot(1,2,1);imagesc(mag);colormap(gray);title('magnitude');
subplot(1,2,2);imagesc(ang);colormap(gray);title('phase');

%% 3.2 
%Eulers formula
%thewse formulas can be obtained through the graphical intrepertation of
%phase and magnitude
%im=sin(phase)*magnitude
%re=cos(phase)*magnitude
clear 
clc
Im=imread('mandrill.tif');
Im=rgb2gray(Im);
Im=im2double(Im);
Imf=fft(Im);
magm=abs(Imf);
angm=angle(Imf);

Ic=imread('clown.tif');
Ic=im2double(Ic);
Icf=fft(Ic);
magc=abs(Icf);
angc=angle(Icf);

subplot(2,4,1);imagesc(magm);colormap(gray);title('mandrill magnitude before');
subplot(2,4,2);imagesc(angm);colormap(gray);title('mandrill phase before');
subplot(2,4,3);imagesc(magc);colormap(gray);title('clown magnitude before');
subplot(2,4,4);imagesc(angc);colormap(gray);title('clown phase before');

Inewm=sin(angc).*magm*1i+cos(angc).*magm;
Inewc=sin(angm).*magc*1i+cos(angm).*magc;

magm=abs(Inewm);
angm=angle(Inewm);
magc=abs(Inewc);
angc=angle(Inewc);

subplot(2,4,5);imagesc(magm);colormap(gray);title('mandrill magnitude after');
subplot(2,4,6);imagesc(angm);colormap(gray);title('mandrill phase after');
subplot(2,4,7);imagesc(magc);colormap(gray);title('clown magnitude after');
subplot(2,4,8);imagesc(angc);colormap(gray);title('clown phase after');

Inewm=real(ifft2(Inewm));
Inewc=real(ifft2(Inewc));
figure
subplot(2,2,1);imshow(Im);title('mandrill before');
subplot(2,2,2);imshow(Ic);title('clown before');
subplot(2,2,3);imshow(Inewm,[]);title('mandrill after');
subplot(2,2,4);imshow(Inewc,[]);title('clown after');

%% 4
clear
clc

I=imread('pattern.tif');
I=im2double(I);
If=fft2(I);
Ifs=fftshift(If);
subplot(1,2,1);imshow(log(1+abs(Ifs)),[]);title('frequancy domain image');
mag=abs(Ifs);
subplot(1,2,2);imagesc(log(1+abs(mag)));colormap(gray);title('magnitude of image');



A=ones(256,256);
%A(126:130,:)=zeros(5,256);
%A(:,126:130)=zeros(256,5);

diff=0;
A(126+diff*5:130+diff*5,126:end)=zeros(5);
A(126-diff*5:130-diff*5,126:end)=zeros(5);

%diff=20;
%A(126+diff*5:130+diff*5,126:130)=zeros(5);
%A(126-diff*5:130-diff*5,126:130)=zeros(5);

figure;mesh(A)
If2=Ifs.*A;
If2=ifftshift(If2);
I2=real(ifft2(If2));
figure;subplot(1,2,1);imshow(I);title('original image');
subplot(1,2,2);imshow(I2,[]);title('filtered image');

