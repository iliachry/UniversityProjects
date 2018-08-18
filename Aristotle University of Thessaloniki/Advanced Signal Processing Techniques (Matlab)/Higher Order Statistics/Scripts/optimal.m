%Advanced Signal Processing Techniques
%Calculation and Depiction of a Window Function of
%Length L used for the calculation of Bispectrum, 
%which is defined by a (Minimum Spectrum Bias Supremum) 
%optima 1-dimensional Window.

function  W = optimal(L)

%Definition
W = zeros(2*L+1);
d = zeros(1,2*L+1);

%Creation of 1-dimensional Window
for m = -L:L
    d(L+1+m) = 1/pi*abs(sin(pi*m/L)) + (1-abs(m)/L)*cos(pi*m/L);
end

%Creation of 2-dimensional Window
for m = -L:L
    for n = -L:L
        if n-m+L+1 >= 1 && n-m+L+1 <= 2*L+1
            W(L+1+m,L+1+n) = d(L+1+m)*d(L+1+n)*d(n-m+L+1);
        end
     end
end

%Depiction
surf(-L:L,-L:L,W);
str=sprintf('Optimal Window: L=%d',L);
legend(str)

end


