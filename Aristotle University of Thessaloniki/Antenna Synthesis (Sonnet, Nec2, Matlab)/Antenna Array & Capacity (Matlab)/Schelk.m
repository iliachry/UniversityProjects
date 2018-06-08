function [ I ] = Schelk( N, R, d, theta0 )
I = Dolph_Chebyshev(N-1, R, d); 
I_inv = flipud(I); 

if( mod(N,2) == 1 )
    for i = 1:floor(N/2)
        I_inv(floor(N/2)+i) = I(i);
    end
else
    for i = 1:N/2
        I_inv(N/2+i) = I(i);
    end
end

    I(1) = -I_inv(1)*exp(1i*2*pi*d*cosd(theta0));
    for j = 2:N-1
        I(j) =I_inv(j-1)-I_inv(j)*exp(1i*2*pi*d*cosd(theta0));
    end
    I(N) = I_inv(N-1);
    theta = 0:2*pi/1000:2*pi;
    AF = 0;
    for j = 1:N
        AF = I(j)*exp(1i*j*2*pi*d*cos(theta))+AF;
    end
    AF = abs(AF/max(AF));
    polar_dB(theta, AF.^2, 100, 25, 16);
end

