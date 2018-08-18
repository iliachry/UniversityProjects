function dw=Dw()
x=500;
a=9/2;
D=0.2/100;
syms l
c=3*10^8;
n=sqrt(1+(0.6961663*l^2/(l^2-0.004629148))+(0.4079426*l^2/(l^2-0.01351206))+(0.8974994*l^2/(l^2-97.934062)));
V=(2*pi*a*n*sqrt(2*D))/l;
x1=double((subs(V,l,1.1)));
x2=double((subs(V,l,1.7)));
[v1,b]=Fiber3(x2,x1,x+2);
[v2]=Fiber3(x2,x1,x);
wavelength=linspace(1.1,1.7,x);
n1=double(subs(n,wavelength));
z=diff(v1.*b,2);
dw=-(((D*n1)./(wavelength*c)).*v2.*z*10^12)/(v1(2)-v1(1))^2;
plot(wavelength,dw)