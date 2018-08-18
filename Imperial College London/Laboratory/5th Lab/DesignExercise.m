clear all;close all;clc;
addpath(genpath('imdata'));

% Do we have to choose a variety of images?

I = imresize(imread('cameraman.tif'), [128 128]);
J = imnoise(I,'gaussian');
figure;
subplot(3,2,1), imshow(I)
title('Noiseless Image')
subplot(3,2,2), imshow(J)
title('Noisy Image')

%% Noiseless Case
% 8x8 blocks
I = im2double(I);
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
nz = find(abs(B)<0.0025);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[8 8],invdct);
subplot(3,2,3), imshow(I2)
title('8x8 DCT blocks')
CR8_noiseless = 128*128/size(nz,1);

% 16x16 blocks
I = im2double(I);
T = dctmtx(16);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[16 16],dct);
nz = find(abs(B)<0.0032);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[16 16],invdct);
subplot(3,2,5),imshow(I2)
title('16x16 DCT blocks')
CR16_noiseless = 128*128/size(nz,1);

%% Noisy Case
% 8x8 blocks
J = im2double(J);
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(J,[8 8],dct);
nz = find(abs(B)<0.034);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[8 8],invdct);
subplot(3,2,4),imshow(I2)
title('8x8 DCT blocks')
CR8 = 128*128/size(nz,1);

% 16x16 blocks
J = im2double(J);
T = dctmtx(16);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(J,[16 16],dct);
nz = find(abs(B)<0.034);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[16 16],invdct);
subplot(3,2,6)
imshow(I2)
title('16x16 DCT blocks')
CR16 = 128*128/size(nz,1);