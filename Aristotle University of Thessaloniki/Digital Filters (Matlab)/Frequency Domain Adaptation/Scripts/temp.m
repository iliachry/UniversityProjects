% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

function y=temp(n,m,s)
s=10*log10(s);
x=wgn(n,m,s);
a=1;
b=[1 0.18];
y=filter(a,b,x);
end