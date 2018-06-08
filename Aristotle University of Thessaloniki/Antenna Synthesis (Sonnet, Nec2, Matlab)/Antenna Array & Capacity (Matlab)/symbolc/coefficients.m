function [ coeff ] = coefficients( N , T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

coeff = zeros(1,N+1);
syms z;

for i=1:(N+1)
    coeff(i) = limit(T /  z^(N-i+1),z, inf);
    T = T - coeff(i) * z^(N-i+1) ; 
end
coeff(N) = limit(T , z, inf);
% coeff(N-1) = limit(T, z^(N-1), inf);
%     coefficients(N-1, T);
% 
% 
% 
% if limit(T, z^N, inf) == 0
%     coeff(N) = 0;
%     coefficients(N-1, T);
% else
%     coeff(N) = limit(T, z^N, inf);
% end

end

