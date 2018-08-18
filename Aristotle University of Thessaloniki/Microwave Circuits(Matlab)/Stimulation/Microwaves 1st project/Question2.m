% Microwaves 2
% 1st Project 

clear all;
close all;

%Constants
a = 2.286*10^(-2);
b = 1.016*10^(-2);
%r0 = 1.5*10^(-3);
%r0 = 2*10^(-3);
r0 = 2.5*10^(-3);
L = 37.48*10^(-3);
m0 = 4*pi*10^(-7);
e0 = 8.854*10^(-12);
am = (4*r0^3)/3;
eta0 = sqrt(m0/e0);
c = 3*10^8;
sigma = 59.87*10^7;

%Variables
%f = 10.3295*10^9:10^3:10.331*10^9;
%f = 10.307*10^9:10^3:10.318*10^9;
f = 10.28*10^9:10^3:10.29*10^9;

omega = 2*pi*f;
b10 = sqrt(m0*e0*omega.^2 - (pi/a)^2);
fc = c/(2*a);
Z10 = eta0 ./ sqrt(1 - (fc./f).^2);
Y10 = 1./Z10;
B_f = -(a*b)./(2*am*b10.*Z10);

Rs = sqrt(omega*m0/(2*sigma));
ac = (Rs.*(1+(2*b/a)*(fc./f).^2))./(b*eta0*sqrt(1-(fc./f).^2));
gamma = ac + 1i*b10;

Gamma_dB = zeros(length(f),1);
T_dB = zeros(length(f),1);

Gamma_dBLoss = zeros(length(f),1);
T_dBLoss = zeros(length(f),1);

%Gamma and T coefficients Calculation
for i=1:length(f)
    ABCD_1 = [1 0; 1j*B_f(i) 1];
    ABCD_2 = [cos(b10(i)*L) 1j*Z10(i)*sin(b10(i)*L); 1j*Y10(i)*sin(b10(i)*L) cos(b10(i)*L)];
    ABCD = ABCD_1*ABCD_2*ABCD_1;
   
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    
    s11 = (A + B/Z10(i) - C*Z10(i) - D)/(A + B/Z10(i) + C*Z10(i) + D);
    s21 = 2/(A+B/Z10(i)+C*Z10(i)+D);
    
    Gamma_dB(i) = 20*log10(abs(s11));
    T_dB(i) = 20*log10(abs(s21)); 
end

%Gamma and T coefficients Calculation with Loss
for i=1:length(f)
    ABCD_1 = [1 0; 1j*B_f(i) 1];
    ABCD_2 = [cosh(gamma(i)*L) Z10(i)*sinh(gamma(i)*L); Y10(i)*sinh(gamma(i)*L) cosh(gamma(i)*L)];
    ABCD = ABCD_1*ABCD_2*ABCD_1;
   
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    
    s11 = (A + B/Z10(i) - C*Z10(i) - D)/(A + B/Z10(i) + C*Z10(i) + D);
    s21 = 2/(A+B/Z10(i)+C*Z10(i)+D);
    
    Gamma_dBLoss(i) = 20*log10(abs(s11));
    T_dBLoss(i) = 20*log10(abs(s21)); 
end

[max1, index1] = max(T_dB);
[max2, index2] = max(T_dBLoss);

for i = 1:length(f)
    if (T_dB(i) > max1 - 3)
        index3 = i;
        break;
    end
end

for i = 1:length(f)
    if (T_dBLoss(i) > max2 - 3)
        index4 = i;
        break;
    end
end

fr1 = vpa(f(index1));
fr2 = vpa(f(index2));
f3dB1 = vpa(f(index3));
f3dB2 = vpa(f(index4));

k = 2*pi*fr1*sqrt(m0*e0);
Rs = sqrt(2*pi*fr1*m0/(2*sigma));
Qc = (k*a*L)^3*b*eta0/(2*pi^2*Rs)/(2*b*L^3+4*a^3*L+a*L^3);

plot(f, Gamma_dB)
hold on
grid on
plot(f, Gamma_dBLoss)
title('Gamma Coefficients')
legend('Without Loss', 'With Loss');
xlabel('f (Hz)');
ylabel('dB');
axis([f(1) f(length(f)) -50 1])

figure 
plot(f, T_dB)
hold on
grid on
plot(f, T_dBLoss)
title('T Coefficients')
legend('Without Loss', 'With Loss');
xlabel('f (Hz)');
ylabel('dB');
axis([f(1) f(length(f)) -25 1])

