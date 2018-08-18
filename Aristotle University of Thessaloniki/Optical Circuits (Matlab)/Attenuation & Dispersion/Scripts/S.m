x=503;
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
db2=(diff(db1,1)./(o(1:length(o)-2)));
lamda=linspace(1.1,1.7,x-3);
dt=Dt3();
s1=((2*pi*c)./(lamda.^2)).^2.*db2.*10^12;
lamda1=linspace(1.1,1.7,x-4);
s2=diff(dt,1)/diff(lamda,1)+ (2./lamda).*dt;
plot(lamda,s1)
hold on
plot(lamda,s2)
grid on
legend('1st','2nd');