%autosysxetish leukou thorivou
xV = randn(1000,1);
autocorr(xV)

%diereunhsh ths logistic
yV=load('logistic.dat');
plot(yV(1:100))
autocorr(yV)
mutualinformation(xV, 20);
mutualinformation(yV, 20);
plot(yV(1:100),yV(2:101),'.')
zV = yV + (10^-2)*randn(30000,1);
plot(zV(1:100),zV(2:101),'.')

%diereunhsh ths RR
rV = load('RR.dat');
plot(rV(1:100),rV(2:101),'.')
autocorr(rV)

%pairnw prwtes diafores
for i=2:1:1081
zVr(i)=rV(i)-rV(i-1);
end
autocorr(zVr)

plot(zVr(1:1080),zVr(2:1081),'.')

%Solution for the Lorenz equations in the time interval [0,100] with initial conditions [1,1,1].
clear all
clc
sigma=10;
beta=8/3;
rho=28;
f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
%'f' is the set of differential equations and 'a' is an array containing values of x,y, and z variables.
%'t' is the time variable
[t,a] = ode45(f,[0 100],[1 1 1]);%'ode45' uses adaptive Runge-Kutta method of 4th and 5th order to solve differential equations
plot3(a(:,1),a(:,2),a(:,3)) %'plot3' is the command to make 3D plot