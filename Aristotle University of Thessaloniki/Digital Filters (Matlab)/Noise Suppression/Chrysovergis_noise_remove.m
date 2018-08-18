%Noise remove
%
%author : Ilias Chrysovergis
%date   : March 2016

clear all
close all

load('sound.mat');
load('noise.mat');

n = length(d);
coefficients = 60;

a = xcorr(u,u,coefficients-1,'unbiased');
a = a(coefficients:(2*coefficients-1));
R = toeplitz(a);

P = zeros(coefficients,1);
P(1) = 0.8;

w = -ones(coefficients,1);

mu = 2 / max(eig(R));

wt = zeros([coefficients,n]); wt(:,1) = w;
y = zeros(n, 1);

A = zeros(coefficients-1,1);
s = [A; u];

for i=coefficients:n
  w = w + mu*(P-R*w);
  wt(:,i) = w;
  y(i) = s(i:-1:i-59)' * w; 
end

y=[y(coefficients:end); A];
e = d - y;

sound(e, Fs);
