clear all;close all;clc;
addpath(genpath('imdata'));

%% 1.
X = imread('cameraman.tif');
X32 = histeq(X, 32);
X16 = histeq(X, 16);
X8 = histeq(X, 8);
X4 = histeq(X, 4);
subplot(4,2,1), imhist(X32,32)
title('32 bins')
subplot(4,2,2), imshow(X32)
subplot(4,2,3), imhist(X16,32)
title('16 bins')
subplot(4,2,4), imshow(X16)
subplot(4,2,5), imhist(X8,32)
title('8 bins')
subplot(4,2,6), imshow(X8)
subplot(4,2,7), imhist(X4,32)
title('4 bins')
subplot(4,2,8), imshow(X4)

%% 2. Code by Exact Histogram Specification/Equalization by Anton Semechko (Mathworks File Exchange)
im=imread('cameraman.tif');
im_0=histeq(im);

H=imhist(im);
H_0=imhist(im_0);

% Original image
%--------------------------------------------------------------------------
figure('color',[1 1 1]) 
h_im=axes('units','normalized','position',[0.05 0.1 0.4 0.8]);
imshow(im)

h_h=axes('units','normalized','position',[0.55 0.1 0.4 0.8]);
bar(0:255,H,'b');
set(h_h,'xlim',[0 255],'FontSize',15,'FontWeight','bold')
set(get(h_h,'Title'),'String','Original Image','FontSize',20,'FontWeight','bold')

Ylim_ref=get(h_h,'ylim');

% Classical histogram equalization
%--------------------------------------------------------------------------
figure('color',[1 1 1]) 
h_im=axes('units','normalized','position',[0.05 0.1 0.4 0.8]);
imshow(im_0)

h_h=axes('units','normalized','position',[0.55 0.1 0.4 0.8]);
bar(0:255,H_0,'b');
set(h_h,'xlim',[0 255],'ylim',Ylim_ref,'FontSize',15,'FontWeight','bold')
set(get(h_h,'Title'),'String','Histogram Modification','FontSize',20,'FontWeight','bold')

%% 3.
I = imread('trees.tif');
figure;
subplot(2,2,1), imshow(edge(I,'sobel'))
title('Sobel')
subplot(2,2,2), imshow(edge(I,'roberts'))
title('Roberts')
subplot(2,2,3), imshow(edge(I,'prewitt'))
title('Prewitt')
subplot(2,2,4), imshow(edge(I,'Log'))
title('Log')

% Images inclined at +/- 45 degrees
J = imrotate(I, 45);
figure;
subplot(1,2,1), imshow(edge(I,'sobel','horizontal'))
title('Sobel, +/- 45 degrees')
subplot(1,2,2), imshow(edge(I,'prewitt','horizontal'))
title('Prewitt, +/- 45 degrees')


%% 4.
% Noise types: 'gaussian', 'localvar', 'poisson', 'salt & pepper',
% 'speckle'
X = imread('autumn.tif');
I = rgb2gray(X);

% Salt & Pepper
J = imnoise(I,'salt & pepper'); 
K = medfilt2(J,[3 3]); % Change the neighbourhood dimensions 
figure;
subplot(4,4,1), imshow(J)
title('Salt & Pepper Noise')
subplot(4,4,2), imshow(K)
title('3x3 Neighbourhood')

K = medfilt2(J,[5 5]); % Change the neighbourhood dimensions 
subplot(4,4,3), imshow(K)
title('5x5 Neighbourhood')

K = medfilt2(J,[7 7]); % Change the neighbourhood dimensions 
subplot(4,4,4), imshow(K)
title('7x7 Neighbourhood')

% Gaussian
J = imnoise(I,'gaussian'); 
K = medfilt2(J,[3 3]); % Change the neighbourhood dimensions 
subplot(4,4,5), imshow(J)
title('Gaussian Noise')
subplot(4,4,6), imshow(K)
title('3x3 Neighbourhood')

K = medfilt2(J,[5 5]); % Change the neighbourhood dimensions 
subplot(4,4,7), imshow(K)
title('5x5 Neighbourhood')

K = medfilt2(J,[7 7]); % Change the neighbourhood dimensions 
subplot(4,4,8), imshow(K)
title('7x7 Neighbourhood')

% Poisson
J = imnoise(I,'poisson'); 
K = medfilt2(J,[3 3]); % Change the neighbourhood dimensions 
subplot(4,4,9), imshow(J)
title('Poisson')
subplot(4,4,10), imshow(K)
title('3x3 Neighbourhood')

K = medfilt2(J,[5 5]); % Change the neighbourhood dimensions 
subplot(4,4,11), imshow(K)
title('5x5 Neighbourhood')

K = medfilt2(J,[7 7]); % Change the neighbourhood dimensions 
subplot(4,4,12), imshow(K)
title('7x7 Neighbourhood')

% Speckle
J = imnoise(I,'speckle'); 
K = medfilt2(J,[3 3]); % Change the neighbourhood dimensions 
subplot(4,4,13), imshow(J)
title('Speckle Noise')
subplot(4,4,14), imshow(K)
title('3x3 Neighbourhood')

K = medfilt2(J,[5 5]); % Change the neighbourhood dimensions 
subplot(4,4,15), imshow(K)
title('5x5 Neighbourhood')

K = medfilt2(J,[7 7]); % Change the neighbourhood dimensions 
subplot(4,4,16), imshow(K)
title('7x7 Neighbourhood')