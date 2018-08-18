

clear all
close all

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
% figure;
% plot(wavelength,n);
% grid on;

%%
dn_l = diff(n,1)./diff(wavelength,1);
dn_l_2 = diff(dn_l,1)./diff(wavelength(1:(length(wavelength)-1)),1);
Dm = -(wavelength(1:(length(wavelength)-2))/c).*dn_l_2*10^12;

figure;
plot(wavelength(1:(length(wavelength)-2)),Dm);
grid on;

flag = 1;
for i=1:length(wavelength)
    if (flag == 1 && i>1);
        if sign(Dm(i)) ~= sign(Dm(i-1))
            flag = 0;
            zero_point_Dm = wavelength(i);
        end
    end
end

%%

V=(pi*diameter*n*sqrt(2*relativeDifference))./wavelength;
[V, b] = Fiber3(V(1), V(600), 600);
dVb_V=diff(V.*b,1)./diff(V,1);
dVb_V_2 = diff(dVb_V,1)./diff(V(1:(length(V)-1)),1);
dw=-(relativeDifference*n(1:598)./(wavelength(1:598)*c)).*V(1:598).*dVb_V_2*10^12;



figure;
plot(wavelength(1:598),dw)

hold on
plot(wavelength(1:599),Dm)


%%

Dt = dw+Dm(1:598);

hold on
plot(wavelength(1:598),Dt)
flag = 1;
for i=1:length(wavelength)
    if (flag == 1 && i>1);
        if sign(Dt(i)) ~= sign(Dt(i-1))
            flag = 0;
            zero_point_Dt1 = wavelength(i);
        end
    end
end

%%

% omega = 2*pi*c./wavelength;
% beta = 2*pi./wavelength.*n.*sqrt(1-2*relativeDifference*(1-b));
% db_omega_1 = diff(beta)./diff(omega);
% db_omega_2 = diff(db_omega_1)./diff(omega(1:(length(omega)-1)));
% 
% Dt2 = -omega(1:(length(omega)-2))./wavelength(1:(length(wavelength)-2)).*db_omega_2*10^12;

omega=2*pi*c./wavelength;
beta=omega(1:600)/c.*n(1:600).*sqrt(1-2*relativeDifference*(1-b));

d2beta=diff(diff(beta)./diff(omega(1:600)))./diff(omega(1:599));
Dt2=-omega(1:598)./wavelength(1:598).*d2beta*10^12;

plot(wavelength(1:598),Dt2);
legend('Dw','Dm','Dt1','Dt2');
    
flag = 1;
for i=1:length(wavelength)
    if (flag == 1 && i>1);
        if sign(Dt2(i)) ~= sign(Dt2(i-1))
            flag = 0;
            zero_point_Dt2 = wavelength(i);
        end
    end
end


    

