function [Gamma_average] = micro31a(p)

%ZL = 200 - 1i*50;
ZL = 5+1i*10;
Z0 = 50;

counter = 0;
sum     = 0;

for normf = (0.01 : 0.01 : 2)
    
    Zin1 = -1i*Z0*cot(2*pi*p(4)*normf);
    Yin1 = 1 / Zin1;
    Zin2 = -1i*Z0*cot(2*pi*p(5)*normf);
    Yin2 = 1 / Zin2;    
    Zin3 = -1i*Z0*cot(2*pi*p(6)*normf);
    Yin3 = 1 / Zin3;
    
    ZA = Z0 * ( ZL + 1i*Z0*tan(2*pi*p(1)*normf)) / (Z0 + 1i*ZL*tan(2*pi*p(1)*normf));
    YA = 1 / ZA;
    YB = Yin1 + YA;
    ZB = 1 / YB;
    
    ZC = Z0 * ( ZB + 1i*Z0*tan(2*pi*p(2)*normf)) / (Z0 + 1i*ZB*tan(2*pi*p(2)*normf));
    YC = 1 / ZC;
    YD = Yin2 + YC;
    ZD = 1 / YD;
    
    ZE = Z0 * ( ZD + 1i*Z0*tan(2*pi*p(3)*normf)) / (Z0 + 1i*ZD*tan(2*pi*p(3)*normf));
    YE = 1 / ZE;
    Yin = Yin3 + YE;
    Zin = 1 / Yin;
    
    Gamma   = abs((Zin - Z0) / (Zin + Z0));
    sum     = sum + Gamma;
    counter = counter + 1;
end
Gamma_average = sum / counter;
end
