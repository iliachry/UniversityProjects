% syms z;
% limit(z /z, z,  inf);
% A = sym('a%d',[1,3])
% syms z z0 a;
% %a = sym('a%d',[1,5])
% 
% coefficients = coeff(9)
% sum = 0;
% for j = 1:1:(length(coefficients))
%   sum = sum + coefficients(j)*(z/z0)^(length(coefficients)-j)  
% end
% A = 0;
% A = A + a*sum

syms a z0;
eqn = 256*a/3^9 ==256;
sol = solve(eqn,a);
sol
