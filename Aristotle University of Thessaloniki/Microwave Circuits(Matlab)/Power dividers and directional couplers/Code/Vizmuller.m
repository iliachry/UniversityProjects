% Microwaves 2
% 2nd Project 

clearvars
close all

%Constants & Variables
Z1 = 50;
Z2 = 100;
Z0 = 50;
R1 = 92;
R2 = 253;
C1 = 0.86*10^-12;
C2 = 0.85*10^-12;
f = 300*10^6:10^5:1200*10^6;
f0 = 600*10^6;
length1 = 1.13*10^(-2);
length2 = 2.84*10^(-2);
theta1 = length1/(8*(length1+length2))*f/f0;
theta2 = length2/(8*(length1+length2))*f/f0;

%S11
Zin1 = Z2*(Z0+(1i)*Z2*tan(2*pi*theta1))./(Z2+(1i)*Z0*tan(2*pi*theta1));
Zin2 = Z1*(Zin1+(1i)*Z1*tan(2*pi*theta2))./(Z1+(1i)*Zin1.*tan(2*pi*theta2));
Zin3 = Z2*(Zin2+(1i)*Z2*tan(2*pi*theta2))./(Z2+(1i)*Zin2.*tan(2*pi*theta2));
Zin4 = Z1*(Zin3+(1i)*Z1*tan(2*pi*theta1))./(Z1+(1i)*Zin3.*tan(2*pi*theta1));
Zin = 0.5*Zin4;
S11 = (Zin-Z1)./(Zin+Z1);

%S21
S21 = zeros(1,length(f));
for j = 1:length(f)
    ABCD1 = [cos(2*pi*theta1(j)) (1i)*Z1*sin(2*pi*theta1(j));((1i)/Z1)*sin(2*pi*theta1(j)) cos(2*pi*theta1(j))];
    ABCD2 = [cos(2*pi*theta2(j)) (1i)*Z2*sin(2*pi*theta2(j));((1i)/Z2)*sin(2*pi*theta2(j)) cos(2*pi*theta2(j))];
    ABCD3 = [cos(2*pi*theta2(j)) (1i)*Z1*sin(2*pi*theta2(j));((1i)/Z1)*sin(2*pi*theta2(j)) cos(2*pi*theta2(j))];
    ABCD4 = [cos(2*pi*theta1(j)) (1i)*Z2*sin(2*pi*theta1(j));((1i)/Z2)*sin(2*pi*theta1(j)) cos(2*pi*theta1(j))];
    ABCD = ABCD1*ABCD2*ABCD3*ABCD4;
    S21(j) = (1+S11(j))/(ABCD(1,1)+ABCD(1,2)/Z0);
end

%S22
%Even
Zin1 = Z1*(2*Z0+(1i)*Z1*tan(2*pi*theta1))./(Z1+(1i)*2*Z0*tan(2*pi*theta1));
Zin2 = Z2*(Zin1+(1i)*Z2*tan(2*pi*theta2))./(Z2+(1i)*Zin1.*tan(2*pi*theta2));
Zin3 = Z1*(Zin2+(1i)*Z1*tan(2*pi*theta2))./(Z1+(1i)*Zin2.*tan(2*pi*theta2));
Zin4 = Z2*(Zin3+(1i)*Z2*tan(2*pi*theta1))./(Z2+(1i)*Zin3.*tan(2*pi*theta1));
GammaEven = (Zin4-Z0)./(Zin4+Z0);

%Odd
Zin1 = (1i)*Z1*tan(2*pi*theta1);
Zin2 = Z2*(Zin1+(1i)*Z2*tan(2*pi*theta2))./(Z2+(1i)*Zin1.*tan(2*pi*theta2));
Yin3 = (2/R1)*ones(1,length(f))+(1i)*(2*pi*f*2*C1)+(1./Zin2);
Zin3 = 1./(Yin3);
Zin4 = Z1*(Zin3+(1i)*Z1*tan(2*pi*theta2))./(Z1+(1i)*Zin3.*tan(2*pi*theta2));
Zin5 = Z2*(Zin4+(1i)*Z2*tan(2*pi*theta1))./(Z2+(1i)*Zin4.*tan(2*pi*theta1));
Yin6 = (2/R2)*ones(1,length(f))+(1i)*(2*pi*f*2*C2)+(1./Zin5);
Zin6 = 1./Yin6;
GammaOdd = (Zin6-Z0)./(Zin6+Z0);
S22 = 0.5*(GammaEven+GammaOdd);

%S32
S32=0.5*(GammaEven-GammaOdd);

%Plots
figure
plot(f, 20*log10(abs(S11)))
hold on
plot(f, 20*log10(abs(S22)))
plot(f, 20*log10(abs(S21)))
plot(f, 20*log10(abs(S32)))
grid on
ylim([-50 0])   
legend('S11','S22','S21','S32')
ylabel('dB')
xlabel('f')
title('S parameters of Vizmuller Power Divider ')

%Bandwidth
for i = 1:length(S32)
    if 20*log10(S32(i)) < -20
        break
    end
end
for j = i:length(S32)
    if 20*log10(S32(j)) > -20
        break
    end
end
BW = 100*(f(j)-f(i))/f0;
