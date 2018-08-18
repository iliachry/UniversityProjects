%% 3.1.c

clear all; close all; clc; 

N = 2000;
d = sqrt(0.25)*randn(1,N);
x = filter(1, [1, -0.1, -0.8], d);
mu = 0.05;
L = 2;

e = zeros(2000,100,2);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [e(:,i,1), ~] = LMS_AR(x, mu, L);
    
    mu = 0.01;
    [e(:,i,2), ~] = LMS_AR(x, mu, L);
end

MSE1 = mean(e(1000:2000,:,1).^2,2);
MSE2 = mean(e(1000:2000,:,2).^2,2);

EMSE1 = mean(MSE1) - 0.25;
EMSE2 = mean(MSE2) - 0.25;

MLMS1 = EMSE1/0.25;
MLMS2 = EMSE2/0.25;

Rxx = [25/27, 25/54; 25/54, 25/27];
MLMS1_Th = 0.5*0.05*trace(Rxx);
MLMS2_Th = 0.5*0.01*trace(Rxx);
