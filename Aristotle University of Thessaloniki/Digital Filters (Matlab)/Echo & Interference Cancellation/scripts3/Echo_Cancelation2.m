%Digital Filters : 3rd exercise 2nd part
%
%Chrysovergis Ilias
%8009
%iliachry@ece.auth.gr

clear all
close all

load('speakerA.mat');
load('speakerB.mat');

%Parameters

n = length(u); % signal samples
M = 6700; %order of the filter

%Wiener filter

r = var(u)*autocorr(u,M-1); 
R = toeplitz(r);
P = xcorr(d,u);
P = P/length(u);
P = P(n:n+M-1);
w0 = R\P; 
y = zeros(n,1);
for i=M+1:n
     y(i) = w0'*u(i:-1:(i-M+1));
end
%e=d-y; 
% sound(e,fs);

%LMS

mu = 0.0005;
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);
J = zeros(n, 1);
for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    e(i) = d(i) - y(i);
    w = w + mu*e(i)*u(i:-1:(i-M+1));
end

%NLMS

mu = 0.5;
a = 100;
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);

for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    e(i) = d(i) - y(i);
    w = w + mu*e(i)*u(i:-1:(i-M+1)) / (a + u(i:-1:(i-M+1))'*u(i:-1:(i-M+1)));
end

%RLS

mu = 0.005;
lambda = 1;
delta = 1/250;
M = 500;                                   
n=40000*5;                                 
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);
P = (1/delta) * eye(M, M);

u=u(20000:n+20000);                        
d=d(20000:n+20000);                        
dividerWaitbar = n/10;
for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    k = ( (lambda^-1)*P*u(i:-1:i-M+1) / (1 + (lambda^-1)*u(i:-1:i-M+1)'*P*u(i:-1:(i-M+1))) );
    e(i) = d(i) - y(i);
    w = w + k * e(i);
    P = (lambda^-1)*P - (lambda^-1)*k*u(i:-1:(i-M+1))'*P;
end

