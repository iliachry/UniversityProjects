% Microwaves 2
% 2nd Project 

clearvars
close all

f = 600*10^6;
Z1 = 50;
Z2 = 100;
r = Z2/Z1;
length = 1/2/pi*acot(sqrt(1+r+1/r));
Zin1 = 1i*Z1*tan(2*pi*length);
Zin2 = Z2*(Zin1+1i*Z2.*tan(2*pi*length))/(Z2+1i*Zin1*tan(2*pi*length));
syms R C 
Zin3 = ((R/2)*((-1i)/(4*pi*f*C)))/((R/2)+((-1i)/(4*pi*f*C)));
[R, C] = solve([real(1/Zin3)+real(1/Zin2)==1/50,imag(1/Zin3)+imag(1/Zin2)==0],[R,C]);
R = double(vpa(R));
C = double(vpa(C));