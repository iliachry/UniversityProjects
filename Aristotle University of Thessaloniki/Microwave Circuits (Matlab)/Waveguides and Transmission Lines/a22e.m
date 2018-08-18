Ze1 = 63.45;
Zo1 = 41.38;
Ze2 = 51.80;
Zo2 = 48.39;
Ze3 = 51.80;
Zo3 = 48.39;
Ze4 = 63.54;
Zo4 = 41.38;
f0   = 3.2;
fmax = 4;
fmin = 2.4;
N    = 200;
ZL = 50;
Z0 = 50;
counter = 1;
Gamma_in = zeros(1,N);
freq = zeros(1,N);

for f = fmin:(fmax-fmin)/N:fmax
    bl=pi/2*f/f0;  
    
    A1=[(Ze1+Zo1)*(exp(1i*2*bl)+1)/(2*exp(1i*bl)*(Ze1-Zo1))...
        ((Ze1+Zo1)^2 *((exp(1i*2*bl)+1)^2)-4*exp(1i*2*bl)*(Ze1-Zo1)^2)/(4*(exp(1i*2*bl)-1)*exp(1i*bl)*(Ze1-Zo1));...
        (exp(1i*2*bl)-1)/(exp(1i*bl)*(Ze1-Zo1))...
       ((Ze1+Zo1)*(exp(1i*2*bl)+1))/(2*exp(1i*bl)*(Ze1-Zo1)) ];
    A2=[(Ze2+Zo2)*(exp(1i*2*bl)+1)/(2*exp(1i*bl)*(Ze2-Zo2)) ...
        ((Ze2+Zo2)^2 *((exp(1i*2*bl)+1)^2)-4*exp(1i*2*bl)*(Ze2-Zo2)^2)/(4*(exp(1i*2*bl)-1)*exp(1i*bl)*(Ze2-Zo2));...   
       (exp(1i*2*bl)-1)/(exp(1i*bl)*(Ze2-Zo2))...
       ((Ze2+Zo2)*(exp(1i*2*bl)+1))/(2*exp(1i*bl)*(Ze2-Zo2)) ];  ...
    A3=[(Ze3+Zo3)*(exp(1i*2*bl)+1)/(2*exp(1i*bl)*(Ze3-Zo3))...  
        ((Ze3+Zo3)^2 *((exp(1i*2*bl)+1)^2)-4*exp(1i*2*bl)*(Ze3-Zo3)^2)/(4*(exp(1i*2*bl)-1)*exp(1i*bl)*(Ze3-Zo3));  ... 
        (exp(1i*2*bl)-1)/(exp(1i*bl)*(Ze3-Zo3)) ...
        ((Ze3+Zo3)*(exp(1i*2*bl)+1))/(2*exp(1i*bl)*(Ze3-Zo3)) ]; ... 
    A4=[(Ze4+Zo4)*(exp(1i*2*bl)+1)/(2*exp(1i*bl)*(Ze4-Zo4)) ...
       ((Ze4+Zo4)^2 *((exp(1i*2*bl)+1)^2)-4*exp(1i*2*bl)*(Ze4-Zo4)^2)/(4*(exp(1i*2*bl)-1)*exp(1i*bl)*(Ze4-Zo4));  ... 
       (exp(1i*2*bl)-1)/(exp(1i*bl)*(Ze4-Zo4))...
       ((Ze4+Zo4)*(exp(1i*2*bl)+1))/(2*exp(1i*bl)*(Ze4-Zo4)) ]; 
        
    Atotal = A1 * A2 * A3 * A4;
    Zin = ( Atotal(1,1) * ZL + Atotal(1,2) ) / ( Atotal(2,1) * ZL + Atotal(2,2));    
    Gamma_in(counter) = 20*log10(abs(( Zin - Z0 ) / ( Zin + Z0 )));
    if (Gamma_in(counter) < -40)
        Gamma_in(counter) = -40;
    end
    freq(counter) = f;
    counter = counter + 1; 
end

figure;
plot(freq,Gamma_in);
grid;
xlabel('Frequency');
ylabel('Reflection Coefficient (dB)');




       