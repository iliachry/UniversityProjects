function [ ] = Dolph_Chebyshev( N, R0 )
%Calculation of the current distribution, the directivity, the HPBW and the
%polar radiation pattern of a broadside Dolph-Chebyshev array with N
%elements, sidelobe heigth -R0 (dB) and distance between the array equal to
%d.
%
%Ilias Chrysovergis
%May 2016

syms u z;

z0 = 1.0851;

if ( mod(N,2) == 0 )
    M = N/2;
    a = sym('a%d',[1,M])
    A = 0;
    for i=1:1:M
        A = A + a(i)*cos((2*i-1)*u);
    end
else
    M = (N+1)/2;
    a = sym('a%d',[1,M])
    A = 0;
    for i=1:1:M
        %sum = zeros(1,M+1);
        
        coefficients = coeff(2*i-1);
        
        sum = 0;
            for j = 1:1:length(coefficients)
                sum = sum + coefficients(j)*(z/z0)^(length(coefficients)-j);  
            end
        A = A + a(i)*sum;
    end
end

% A
% T1 = simplify(T(N));
% coefficients = coeff(N);
% j = 0;
% sol = sym('sol%d',[1,M]);
% current = zeros(1,M+1);
% for i = 1:1:N
%     temp = limit(A / z^(N-i+1) , z, inf)
%     A = A - temp*z^(N-i+1);
%     simplify(A)
%     if temp ~=0
%         j = j + 1;
%         eqn(j) = temp == coefficients(i);
%         
%     end
% end
% sol = vpasolve(eqn, a)
% %         a((N+1)/2-j+1)=(sol(j));
% % double(a) 

A
T1 = simplify(T(N));
coefficients = coeff(N);
j = 0;
sol = sym('sol%d',[1,M]);
current = zeros(1,M+1);
for i = 1:1:N
    temp = limit(A / z^(N-i+1) , z, inf)
    A = A - temp*z^(N-i+1);
    simplify(A);
    if temp ~=0
        j = j + 1;
        eqn = temp == coefficients(i);
        sol(j) = vpasolve(eqn, a((N+1)/2-j+1));
        a((N+1)/2-j+1)=sol(j);
        A = subs(A,a5,sol(j))
    end
end
a(4) = subs(a(4),a(5),2.1)
z0 = 1.0851;

        

% for i = 1:1:N
%     temp = limit(T1 / z^(2*M-i), z, inf) - limit(A / z^(2*M-i) , z, inf);
%     T1 = T1 - limit(T1 / z^(2*M-i), z, inf) * z^(2*M-i);
%     A = A - limit(A / z^(2*M-i) , z, inf);
%     sol = solve(temp,a((M-i+1)));
%     sol
% end

% current = zeros(1,N+1);
% 
% for i=1:1:N
    
% coefficients = zeros(1,N+1);
% syms z;
% 
% for i=1:(N+1)
%     coefficients(i) = limit(T1 /  z^(N-i+1),z, inf);
%     T1 = T1 - coefficients(i) * z^(N-i+1) ; 
% end
% coefficients



end

