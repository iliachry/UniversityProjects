function [dt,x]=Dt3()
[~,x]=Dm();
x=x+2;
c=3*10^8;
syms l
a=9/2;D=0.2/100;
lamda=linspace(1.1,1.7,x);
omega=2*pi*c./lamda;
n=sqrt(1+(0.6961663*l^2/(l^2-0.004629148))+(0.4079426*l^2/(l^2-0.01351206))+(0.8974994*l^2/(l^2-97.934062)));
V=(2*pi*a*n*sqrt(2*D))/l;
V=double(subs(V,l,lamda));
b(1:length(V))=0;
n1=subs(n,l,lamda);
for i=1:length(V)
    b(i)=Fiber2(V(i));
end
beta=double((2*pi./lamda).*n1.*(sqrt(1-2*D.*(1-b))));
db=(diff(beta,1)./(diff(omega,1)));
o=diff(omega,1);
db1=(diff(db,1)./(o(1:length(o)-1)));
lamda1=linspace(1.1,1.7,x-2);
dt=-((2*pi*c)./(lamda1.^2)).*db1.*10^12;
dt1=Dt();
close all
figure
plot(lamda1,dt)
grid on
hold on
plot(lamda(1:x-2),dt1);
xlabel('Wavelength in ìm')
legend('Direct Calculation','Indirect Calculation')
x=x-2;
end