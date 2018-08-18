% Microwaves 2
% 2nd Project 

clearvars
close all

%Constants & Variables
z1 = 1;
z2 = 2;
r = z2/z1;
R = 2;
C = 70.983*10^(-12);
f = 300*10^6:10^5:900*10^6;
f0 = 600*10^6;
l = 1/2/pi*acot(sqrt(1+r+1/r)).*f/f0;

%S11
Zin1 = z2*(z1+(1i)*z2.*tan(2*pi*l))./(z2+(1i)*z1.*tan(2*pi*l));
Zin2 = z1*(Zin1+(1i)*z1.*tan(2*pi*l))./(z1+(1i)*Zin1.*tan(2*pi*l));
Zin = 0.5*Zin2;
S11 = (Zin-z1)./(Zin+z1);
%S21
S21 = zeros(1,length(f));
for i = 1:length(f)
    ABCD1 = [cos(2*pi*l(i)) (1i)*z1*sin(2*pi*l(i));((1i)/z1)*sin(2*pi*l(i)) cos(2*pi*l(i))];
    ABCD2 = [cos(2*pi*l(i)) (1i)*z2*sin(2*pi*l(i));((1i)/z2)*sin(2*pi*l(i)) cos(2*pi*l(i))];
    ABCD = ABCD1*ABCD2;
    S21(i) = 0.5*(1-S11(i))/(ABCD(2,1)+ABCD(2,2));
end
%S22,S32
%Even
Zin1 = z1*(z2+(1i)*z1.*tan(2*pi*l))./(z1+(1i)*z2.*tan(2*pi*l));
Zin2 = z2*(Zin1+(1i)*z2.*tan(2*pi*l))./(z2+(1i)*Zin1.*tan(2*pi*l));
GammaEven = (Zin2-z1)./(Zin2+z1);
% Odd
Zin1 =(1i)*z1*tan(2*pi*l);
Zin2 = z2*(Zin1+(1i)*z2.*tan(2*pi*l))./(z2+(1i)*Zin1.*tan(2*pi*l));
Zin3 = ((R/2)*((-1i)./(4*pi*f*C)))./((R/2)+((-1i)./(4*pi*f*C)));
Zin3 = (Zin3.*Zin2)./(Zin3+Zin2);
GammaOdd = (Zin3-z1)./(Zin3+z1);
S22 = 0.5*(GammaEven+GammaOdd);
S32 = 0.5*(GammaEven-GammaOdd);

%Plot
plot(f, 20*log10(abs(S11)))
hold on
plot(f, 20*log10(abs(S22)))
plot(f, 20*log10(abs(S32)))
plot(f, 20*log10(abs(S21)))
legend('S11','S22','S32','S21')
ylim([-50 0])
grid on
ylabel('dB')
xlabel('f')
title('S Parameters of Webb Power Divider')

%Bandwidth
index1 = (length(f)+1)/2;
index2 = 0;
for i = 1:index1
    if 20*log10(abs(S32(i)))>-20
        index2 = i;
    end
end
BW = 200*(f(index1)-f(index2))/f0;