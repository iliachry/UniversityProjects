% Microwaves 2
% 1st Project 

clear all;
close all;

%Constants
a = 2.286*10^(-2);
b = 1.016*10^(-2);
r0 = 2*10^(-3);
L = 37.48*10^(-3);
m0 = 4*pi*10^(-7);
e0 = 8.854*10^(-12);
am = (4*r0^3)/3;
eta0 = sqrt(m0/e0);
c = 3*10^8;

%Variables
%f = 7*10^9:10^4:12.5*10^9;
f = 7.655*10^9:10^2:7.685*10^9;
%f = 10.3*10^9:10^3:10.33*10^9;

omega = 2*pi*f;
b10 = sqrt(m0*e0*omega.^2 - (pi/a)^2);
fc = c/(2*a);
Z10 = eta0 ./ sqrt(1 - (fc./f).^2);
Y10 = 1./Z10;
B_f = -(a*b)./(2*am*b10.*Z10);

Gamma_dB = zeros(length(f),1);
T_dB = zeros(length(f),1);

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
plot(f, Gamma_dB)
hold on
grid on
plot(f, T_dB)
title('Gamma and T Coefficients')
legend('Gamma', 'T');
xlabel('f (Hz)');
ylabel({});
axis([f(1) f(length(f)) -50 1])
