% Microwaves 2
% 1st Project 

clear all;
close all;

%Constants
a = 2.286*10^(-2);
b = 1.016*10^(-2);
r0 = 10^(-3)*[1.5 2 2.5];
L = 37.48*10^(-3);
m0 = 4*pi*10^(-7);
e0 = 8.854*10^(-12);
am = (4*r0.^3)/3;
eta0 = sqrt(m0/e0);
c = 3*10^8;

%Variables
f = 10.2*10^9:10^3:10.4*10^9;
omega = 2*pi*f;
b10 = sqrt(m0*e0*omega.^2 - (pi/a)^2);
fc = c/(2*a);
Z10 = eta0 ./ sqrt(1 - (fc./f).^2);
Y10 = 1./Z10;

Gamma_dB = zeros(length(f),3);
T_dB = zeros(length(f),3);

for j = 1:3
    B_f = -(a*b)./(2*am(j)*b10.*Z10);
    for i = 1:length(f)
    
    ABCD = [1 0; 1j*B_f(i) 1];
   
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    
    s11 = (A + B/Z10(i) - C*Z10(i) - D)/(A + B/Z10(i) + C*Z10(i) + D);
    s21 = 2/(A+B/Z10(i)+C*Z10(i)+D);
       
    Gamma_dB(i,j) = 20*log10(abs(s11));
    T_dB(i,j) = 20*log10(abs(s21)); 
    end
    
    figure(1)
    plot(f,Gamma_dB(:,j))
    hold on
    grid on

    figure(2)
    plot(f,T_dB(:,j)) 
    hold on
    grid on
end


figure(1)
title('Gamma Coefficient')
legend('r0 = 1.5mm','r0 = 2mm','r0 = 2.5mm');
xlabel('f (Hz)');
ylabel('dB')

figure(2)
title('T Coefficient')
legend('r0 = 1.5mm','r0 = 2mm','r0 = 2.5mm');
xlabel('f (Hz)');
ylabel('dB')
