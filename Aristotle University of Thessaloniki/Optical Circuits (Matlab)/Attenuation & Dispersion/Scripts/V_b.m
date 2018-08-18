function [V,b]=Fiber3(x1,x2,m)
close all
V=linspace(x1,x2,m);
b0=0.95;
u=length(V);
oldoptions=optimoptions('fsolve');
options=optimoptions(oldoptions,'Tolfun',10^(-15));
for i=1:u
    f = @(b)parameterfun(b,V(i));
    c(i)=fsolve(f,b0,options);
end
b=abs(c);
end