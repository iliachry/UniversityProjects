clear all;close all;clc;
addpath(genpath('imdata'));

%% FFT 
% a.
image1 = imread('cameraman.tif');
image1_fft = log(1+fft2(image1));
imagesc(abs(fftshift(image1_fft)))
title('Log Magnitude of the FFT of the cameraman')


% b.
a_im1 = zeros(64,64);
for i = 1:4:64
    for j = 1:4:64
        a_im1(i,j) = 1;
    end
end
subplot(3,2,1), imshow(a_im1);
title('Image')
a_im1_fft = fft2(a_im1);
subplot(3,2,2), imshow(a_im1_fft)
title('FFT')

a_im2 = zeros(64,64);
for i = 1:8:64
    for j = 1:8:64
        a_im2(i,j) = 1;
    end
end
subplot(3,2,3), imshow(a_im2);
title('Image')
a_im2_fft = fft2(a_im2);
subplot(3,2,4)
imshow(a_im2_fft)
title('FFT')

a_im3 = zeros(64,64);
for i = 1:16:64
    for j = 1:16:64
        a_im3(i,j) = 1;
    end
end
subplot(3,2,5), imshow(a_im3);
title('Image')
a_im3_fft = fft2(a_im3);
subplot(3,2,6),
imshow(a_im3_fft)
title('FFT')

% c.
image1 = imread('cameraman.tif');
image1_fft = fft2(image1);
image2 = imresize(imread('coins.png'), [256 256]);
image2_fft = fft2(image2);
image_new_fft = abs(image2_fft).*exp(1i*angle(image1_fft));
figure;
imagesc(abs(ifft2(image_new_fft)))

%% DCT
% a.
X = imread('autumn.tif');
I = rgb2gray(X);
J = dct2(I);
figure;
colormap(jet(64)), imagesc(log(abs(J))), colorbar

% b. Compare the results with those of the FFT

%% Hadamard Transform 
image = im2double(image1);
N = 256;
y1 = fwht(image, N, 'sequency');
subplot(1,3,1),
imshow(y1)
title('Sequency')

y2 = fwht(image,N, 'hadamard');
subplot(1,3,2), imshow(y2);
title('Hadamard')

y3 = fwht(image, N, 'dyadic');
subplot(1,3,3), imshow(y3);
title('Dyadic')

x = ifwht(y1, N, 'sequency');
figure;
imshow(x)