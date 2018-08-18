clear all;close all;clc;
addpath(genpath('imdata'));

%% Use original image
% Threshold = 10
X = imread('autumn.tif');
I = rgb2gray(X);
J = dct2(I);
nz = find(abs(J)<10); 
J(nz) = zeros(size(nz));
K = idct2(J)/255;
subplot(2,2,1), imshow(K), axis off
title(' Threshold = 10')

% Use different thresholds also
nz = find(abs(J)<20); 
J(nz) = zeros(size(nz));
K = idct2(J)/255;
subplot(2,2,2), imshow(K), axis off
title(' Threshold = 20')

nz = find(abs(J)<30); 
J(nz) = zeros(size(nz));
K = idct2(J)/255;
subplot(2,2,3), imshow(K), axis off
title(' Threshold = 30')

nz = find(abs(J)<40); 
J(nz) = zeros(size(nz));
K = idct2(J)/255;
subplot(2,2,4), imshow(K), axis off
title('Threshold = 40')

%% Use smaller blocks of the image
I = imread('cameraman.tif');
I = im2double(I);
figure;

% 8x8 blocks
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
nz = find(abs(B)<0.1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[8 8],invdct);
subplot(3,3,1), imshow(I2)
title('8x8 block, th = 0.1') 

% 16x16 blocks
T = dctmtx(16);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[16 16],dct);
nz = find(abs(B)<0.1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[16 16],invdct);
subplot(3,3,2), imshow(I3)
title('16x16 block, th = 0.1') 

% 32x32 blocks
T = dctmtx(32);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[32 32],dct);
nz = find(abs(B)<0.1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[32 32],invdct);
subplot(3,3,3), imshow(I3)
title('32x32 block, th = 0.1') 

% 8x8 blocks
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
nz = find(abs(B)<0.5);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[8 8],invdct);
subplot(3,3,4), imshow(I2)
title('8x8 block, th = 0.5') 

% 16x16 blocks
T = dctmtx(16);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[16 16],dct);
nz = find(abs(B)<0.5);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[16 16],invdct);
subplot(3,3,5), imshow(I3)
title('16x16 block, th = 0.5') 

% 32x32 blocks
T = dctmtx(32);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[32 32],dct);
nz = find(abs(B)<0.5);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[32 32],invdct);
subplot(3,3,6), imshow(I3)
title('32x32 block, th = 0.5') 

% 8x8 blocks
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
nz = find(abs(B)<1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B,[8 8],invdct);
subplot(3,3,7), imshow(I2)
title('8x8 block, th = 1') 

% 16x16 blocks
T = dctmtx(16);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[16 16],dct);
nz = find(abs(B)<1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[16 16],invdct);
subplot(3,3,8), imshow(I3)
title('16x16 block, th = 1') 

% 32x32 blocks
T = dctmtx(32);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[32 32],dct);
nz = find(abs(B)<1);
B(nz) = zeros(size(nz));
invdct = @(block_struct) T' * block_struct.data * T;
I3 = blockproc(B,[32 32],invdct);
subplot(3,3,9), imshow(I3)
title('32x32 block, th = 1') 
