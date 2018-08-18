clear all;close all;clc;
addpath(genpath('imdata'));

% Use a 5x5 and a 7x7 Gaussian degradation with 20 dB noise.
I = imread('cameraman.tif');

h1 = fspecial('gaussian',[5 5], 2);
J1 = imfilter(I,h1,'conv','circular');

h2 = fspecial('gaussian',[7 7], 2);
J2 = imfilter(I,h2,'conv','circular');

figure;
subplot(1,3,1), imshow(I)
title('Original Image')
subplot(1,3,2), imshow(J1)
title('5x5 Gaussian Degradation')
subplot(1,3,3), imshow(J2)
title('7x7 Gaussian Degradation')

%% Inverse Filtering
hf1 = fft2(h1,256,256);
Inv_im1 =  real(ifft2((abs(hf1) > 0.001).*fft2(J1)./hf1));
figure;
subplot(1,2,1)
imshow(Inv_im1)
title('Inverse Restoration of 5x5 Degradation');

hf2 = fft2(h2,256,256);
Inv_im2 =  real(ifft2((abs(hf2) > 0.001).*fft2(J2)./hf2));
subplot(1,2,2)
imshow(Inv_im2)
title('Inverse Restoration of 7x7 Degradation');


%% Wiener Filtering
estimated_nsr = 1;

wnr2 = deconvwnr(J1, h1, estimated_nsr);
figure, 
subplot(2,2,1), imshow(J1)
title('5x5 Gaussian Degradation')
subplot(2,2,2), imshow(wnr2)
title('Wiener Restoration of 5x5 Degradation')

wnr3 = deconvwnr(J2, h2, estimated_nsr);
subplot(2,2,3), imshow(J2)
title('7x7 Gaussian Degradation')
subplot(2,2,4), imshow(wnr3)
title('Wiener Restoration of 7x7 Degradation')
