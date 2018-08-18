Zin1 = 4.9678 + 1i * 43.9439;   
Zin2 = 108.5347 + 1i * 202.0158;
f0 = 10^(10) ;
c0 = 3 * 10^(8);
d = 1.5 * 10^(-3);
L = 6 *10^(-2);
a = 2.286 * 10^(-2);
b = 1.016  * 10^(-2);
eta0 = 120 * pi ; 
eo = 8.854 * 10^(-12);

fc0 = c0 / (2 *a); 
Z0 = eta0 / sqrt(1-(fc0/f0)^2);

k0 = 2* pi * f0  / c0;

beta0 = k0 * sqrt(1-(fc0/f0)^2);

ZA1 = Z0 * (-Zin1 + 1i * Z0 * tan(beta0*(L - d))) / (-Z0 + 1i * Zin1 * tan(beta0*(L-d)));
ZA2 = Z0 * (-Zin2 + 1i * Z0 * tan(beta0*(L - 2*d))) / (-Z0 + 1i * Zin2 * tan(beta0*(L-2*d)));

Z1 = ZA1 / ((2 * ZA1 / ZA2) - 1)^(1/2);

er_complex = (eta0 / Z1)^2 + (fc0/f0)^2;

er = real(er_complex)
tand = -1 * imag(er_complex) / er 