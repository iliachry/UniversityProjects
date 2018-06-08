function [ coefficients ] = coeff( N )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

T1 = simplify(T(N));

coefficients = zeros(1,N+1);
syms z;

for i=1:(N+1)
    coefficients(i) = limit(T1 /  z^(N-i+1),z, inf);
    T1 = T1 - coefficients(i) * z^(N-i+1) ; 
end

end

