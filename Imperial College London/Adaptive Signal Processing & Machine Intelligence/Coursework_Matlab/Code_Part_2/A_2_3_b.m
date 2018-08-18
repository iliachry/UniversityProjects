%% 2.3.b

clear all; close all; clc;

load('PCAPCR.mat');

r = 3;
[U,S,V] = svd(Xnoise);

Xnoise_2 = U(1:1000,1:r)*S(1:r,1:r)*V(1:10,1:r)';

error1 = immse(Xnoise, X);
error2 = immse(Xnoise_2, X);
error3 = immse(Xnoise, Xnoise_2);