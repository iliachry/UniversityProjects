function [ I, D, D2, HPBW1, HPBW2 ] = Dolph_Chebyshev( N,R0,d )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

coefficients = zeros(N,N);
coefficients(1,1) = 1;%T0
coefficients(2,2) = 1;%T1
for j = 3:N
    for i = 1:N
        if (i == 1)
            coefficients(i,j) = -coefficients(i,j-2);
        else
            coefficients(i,j) = 2*coefficients(i-1,j-1) - coefficients(i,j-2);
        end
    end
    if (mod(N,2) == 0)
        A = coefficients(2:2:N,2:2:N);
        B = coefficients(2:2:N,N);
    else
        A = coefficients(1:2:N,1:2:N);
        B = coefficients(1:2:N,N);
    end
    
    z0 = cosh(1/(N-1)*acosh(10^(R0/20)));
    for i = 1:size(A,1)
        A(i,:) = A(i,:)/z0^(2*i-1-mod(N,2));
    end
end
X = A \ B

end

