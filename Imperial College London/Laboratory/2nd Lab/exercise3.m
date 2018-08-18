Nc = 10;
N0 = 1;
lamda = .2;
mu = .2;
h = [.1 + .1i,.2 + .8i,.01 + .2i,1 + 1i,3 + 1i,.1 + .7i,.09 + .02i,.1 + .8i,.4 + .8i,.1 + .3i];
P = zeros(1,Nc);  

for i = 1:10
    P(i) = 1/(lamda - mu*abs(h(i))^2) - N0/abs(h(i))^2;
    if P(i) < 0 
        P(i) = 0;
    end
end

Ptot = sum(P);
Pd = sum(abs(h).^2.*P + N0);

