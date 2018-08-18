syms Ze Zo beta l ;

A = [1 1 1 1;  
    1 1 -1 -1;   
    exp(-1i*beta*l) exp(1i*beta*l) exp(-1i*beta*l) exp(1i*beta*l);   
    exp(-1i*beta*l) exp(1i*beta*l) -exp(-1i*beta*l) -exp(1i*beta*l)];

B = [1/Ze -1/Ze 1/Zo -1/Zo;   
    1/Ze -1/Ze -1/Zo 1/Zo;   
    exp(-1i*beta*l)/Ze -exp(1i*beta*l)/Ze exp(-1i*beta*l)/Zo -exp(1i*beta*l)/Zo;   
    exp(-1i*beta*l)/Ze -exp(1i*beta*l)/Ze -exp(-1i*beta*l)/Zo exp(1i*beta*l)/Zo];

Z = A * inv(B);

Z1 = simplify(Z);

pretty(Z1)
                         
                         
    