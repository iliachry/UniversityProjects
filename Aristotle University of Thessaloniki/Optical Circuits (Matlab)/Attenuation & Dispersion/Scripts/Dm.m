function [Dmat,y]=Dm()
syms l
c=3*10^8;
y=500;
n=sqrt(1+(0.6961663*l^2/(l^2-0.004629148))+(0.4079426*l^2/(l^2-0.01351206))+(0.8974994*l^2/(l^2-97.934062)));
z=vpa(diff(n,l,2));
wavelength=linspace(1.1,1.7,500);
Dmat=-(wavelength/c).*(subs(z,wavelength))*10^12;
figure
plot(wavelength,Dmat)
grid on
u=z*l/c*10^12;
g=matlabFunction(u);
x=fsolve(g,3);
end