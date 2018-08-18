diameter = 9 ; 
relativeDifference = 0.002;
% wavelength = 1.1:0.0001:1.7;
wavelength = 1.1:0.001:1.7;
c = 3 * 10^8 ;

%%
a = [0.6961663, 0.4079426, 0.8974994];
b = [0.004629148, 0.01351206, 97.93406];
nSquared = zeros(0,length(wavelength));
n = zeros(0,length(wavelength));

for i = 1:length(wavelength)
    nSquared(i) = 1; 
    for j = 1:3
        nSquared(i) = nSquared(i) + (a(j)*(wavelength(i))^2) / ((wavelength(i))^2 - b(j)); 
    end
    n(i) = (nSquared(i))^(1/2);
end


V=(pi*diameter*n*sqrt(2*relativeDifference))./wavelength;
[V, b] = Fiber3(V(1), V(600), 600);

omega=2*pi*c./wavelength;
beta=omega(1:600)/c.*n(1:600).*sqrt(1-2*relativeDifference*(1-b));

d2beta=diff(diff(beta)./diff(omega(1:600)))./diff(omega(1:599));
Dt2=-omega(1:598)./wavelength(1:598).*d2beta*10^12;

plot(wavelength(1:598),Dt2);
legend('Dt2');