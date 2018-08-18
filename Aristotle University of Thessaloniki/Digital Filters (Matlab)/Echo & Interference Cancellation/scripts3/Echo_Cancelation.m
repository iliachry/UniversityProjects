%Digital Filters : 3rd exercise 2nd part
%
%Chrysovergis Ilias
%8009
%iliachry@ece.auth.gr

clear all
close all

%Parameters and signals

n = 3000; % signal samples
M = 11; %filter order
sigma = 0.73;
v1 = sqrt(sigma) * randn(n,1);
v1 = v1 - mean(v1);
sigma = 0.39;
v2 = sqrt(sigma) * randn(n,1);
v2 = v2 - mean(v2);

u=zeros(n,1);
for i=1:3
   u(i)=v1(i); 
end
for i=4:n
    u(i)=-0.87*u(i-1)-0.12*u(i-2)-0.032*u(i-3)+v1(i);
end

s=zeros(n,1);

s(1)=-0.23*u(1);
s(2)= -0.23*u(2) + 0.67*u(1);
s(3)= -0.23*u(3)+0.67*u(2)-0.18*u(1);
for i=4:n
   s(i)= -0.23*u(i)+0.67*u(i-1)-0.18*u(i-2)-0.39*u(i-3);
end

x=zeros(n,1);
x(1) = v2(1);
x(2) = -0.57*x(1)+v2(2);
x(3) = -0.57*x(2)-0.16*x(1)+ v2(3);
for i=4:n
    x(i)=-0.57*x(i-1)-0.16*x(i-2)-0.08*x(i-3)+v2(i);
end

d = s + x;

%Wiener Filter 

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

 e=d-y;
 figure
 semilogy((e-x).^2)
 title('Square Error of Wiener Filter')
 xlabel('n');
 ylabel('Square Error');
 Wiener_Error = (e-x).^2;

%LMS

mu = 0.001;
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);
J = zeros(n, 1);

for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    e(i) = d(i) - y(i);
    w = w + mu*e(i)*u(i:-1:(i-M+1));
    J(i) = (e(i)-x(i))^2;
end

figure
semilogy(J)
title('Square Error of LMS')
xlabel('n');
ylabel('Square Error');
LMS_Error = J;

%NLMS

mu = 0.05;
a = 100;
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);
J = zeros(n, 1);

for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    e(i) = d(i) - y(i);
    w = w + mu*e(i)*u(i:-1:(i-M+1)) / (a + u(i:-1:(i-M+1))'*u(i:-1:(i-M+1)));
    J(i) = (e(i)-x(i))^2;
end

figure
semilogy(J)
title('Square Error of NLMS')
xlabel('n');
ylabel('Square Error');
NLMS_Error = J;

%RLS

mu = 0.005;
lambda = 1;
delta = 1/250;
w = zeros(M,1);
y = zeros(n,1);
e = zeros(n,1);
J = zeros(n,1);
P = (1/delta) * eye(M, M);

for i = (M+1):n
    y(i) = w'*u(i:-1:(i-M+1));
    k = ( (lambda^-1)*P*u(i:-1:i-M+1) / (1 + (lambda^-1)*u(i:-1:i-M+1)'*P*u(i:-1:(i-M+1))) );
    e(i) = d(i) - y(i);
    w = w + k * e(i);
    P = (lambda^-1)*P - (lambda^-1)*k*u(i:-1:(i-M+1))'*P;
    J(i) = (e(i)-x(i))^2;
end

figure
semilogy(J)
title('Square Error of RLS')
xlabel('n');
ylabel('Square Error');
RLS_Error = J;

%results

figure
title('Results of Square Errors')
semilogy(1:n,Wiener_Error,1:n,LMS_Error,1:n,NLMS_Error,1:n,RLS_Error)
xlabel('n');
ylabel('Square Error');
legend('Wiener','LMS','NLMS','RLS');