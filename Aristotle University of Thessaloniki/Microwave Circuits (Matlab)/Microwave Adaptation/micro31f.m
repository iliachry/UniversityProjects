function [Gamma_average] = micro31f(p)
%ZL = 200 - 1i*50;
ZL = 5 + 1i*10;
Z0 = 50;
d  = p(1);
Z1 = p(2)*Z0;
Z2 = p(3)*Z0;
Z3 = p(4)*Z0;
Z4 = p(5)*Z0;
sum = 0;
counter = 0;
for normf = (0.01 : 0.01 : 2)
    ZA = Z0 * ( ZL + 1i*Z0*tan(2*pi*d*normf)) / (Z0 + 1i*ZL*tan(2*pi*d*normf));
    ZB = Z1 * ( ZA + 1i*Z1*tan(pi/2*normf)) / (Z1 + 1i*ZA*tan(0.5*pi*normf));
    ZC = Z2 * ( ZB + 1i*Z2*tan(0.5*pi*normf)) / (Z2 + 1i*ZB*tan(0.5*pi*normf));
    ZD = Z3 * ( ZC + 1i*Z3*tan(0.5*pi*normf)) / (Z3 + 1i*ZC*tan(0.5*pi*normf));
    Zin = Z4 * ( ZD + 1i*Z4*tan(0.5*pi*normf)) / (Z4 + 1i*ZD*tan(0.5*pi*normf));
    Gamma   = abs((Zin - Z0) / (Zin + Z0));
    sum     = sum + Gamma;
    counter = counter + 1;
end
Gamma_average = sum / counter;
end