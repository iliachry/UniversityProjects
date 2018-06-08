

function [ I, HPBW_Chebyshev, D ] = Dolph_Chebyshev( N, R, d_over_lamda ) 

R0 = 10^(R/20);
z0 = cosh(1/(N-1)*acosh(R0));
f  = 1 + 0.636*(2/R0*cosh(sqrt((acosh(R0))^2-pi^2)))^2; 

HPBW = 48.4/(N*d_over_lamda); 
HPBW_Chebyshev = f*HPBW;

D = 2*R0^2/(1+(R0^2-1)*f/(N*d_over_lamda));
D = 10*log10(D);

%Chebyshev Coefficients

coefficients = zeros(N);
coefficients(1,1) = 1;
coefficients(2,2) = 1;
for i = 3:N
    coefficients(i,1) = -coefficients(i-2,1);
    for j = 2:N
        coefficients(i,j) = 2*coefficients(i-1, j-1)-coefficients(i-2, j);
    end
end

%Current and Antenna Factor Calculation

if ( mod(N,2) == 0 )
    
    j = 1;
    for i = 2:2:N
        K(j,:) = coefficients(i,:);
        j = j+1;
    end
    j = 1;
    A = zeros(N/2);
    for i = 2:2:N
      A(:,j) = K(:,i);
      j = j+1;
    end
    A = A';
    L = coefficients(N,:)';
    j = 1;
    for i = 2:2:N
        B(j) = L(i)*z0^i;
        j = j+1;
    end
    B = B';
    I = A\B;
    for i = 1:N/2
        I(i) = I(i)/I(N/2); 
    end
    
    theta = 0:2*pi/1000:2*pi;
    u = pi*d_over_lamda*cos(theta);
    AF = 0;
    for i = 1:(N/2)
        AF = I(i)*cos((2*i-1)*u) + AF; 
    end
    AF = AF/max(AF); 
    polar_dB(theta, AF.^2, 100, 25, 16)
    
else
    
    j = 1;
    for i = 1:2:N
        K(j,:) = coefficients(i,:);
        j = j+1;
    end
    j = 1;
    A = zeros(floor(N/2)+1);
    for i=1:2:N
      A(:,j) = K(:,i);
      j = j+1;
    end
    A = A';
    L = coefficients(N,:)';
    j = 1;
    for i = 1:2:N
        B(j) = L(i)*z0^i;
        j = j+1;
    end
    B = B';
    I = A\B;
    for i = 1:floor(N/2)+1
        I(i) = I(i)/I(floor(N/2)+1);
    end
    
    theta = 0:2*pi/1000:2*pi;
    u = pi*d_over_lamda*cos(theta);
    AF = 0;
    for i = 1:floor(N/2)+1
        AF = I(i)*cos(2*(i-1)*u)+AF;
    end
    AF = AF/max(AF);
    polar_dB(theta, AF.^2, 100,25, 16);
    
end 

end

