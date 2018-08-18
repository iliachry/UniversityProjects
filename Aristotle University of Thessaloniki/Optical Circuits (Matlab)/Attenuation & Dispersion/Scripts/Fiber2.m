function b=Fiber2(V)
close all
b0=0.95;
u=length(V);
oldoptions=optimoptions('fsolve');
options=optimoptions(oldoptions,'Tolfun',10^(-15));
c(1:length(V))=0;
for i=1:u
    f = @(b)parameterfun(b,V(i));
    c(i)=fsolve(f,b0,options);
end
b=abs(c);
end