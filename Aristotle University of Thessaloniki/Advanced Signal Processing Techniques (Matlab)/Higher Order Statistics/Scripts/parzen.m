%Advanced Signal Processing Techniques
%Calculation and Depiction of a Window Function of
%Length L used for the calculation of Bispectrum, 
%which is defined by a Parzen 1-dimensional Window.

function W = parzen(L)

%Definition
W = zeros(2*L + 1, 2*L + 1);
d = zeros(1, 2*L + 1);

%Creation of 1-dimensional Window
for m = -L:L
    if abs(m) <= L/2
        d(m+L+1) = 1-6*(abs(m)/L)^2 + 6*(abs(m)/L)^3;
    else
        d(m+L+1) = 2*(1-abs(m)/L)^3;
    end
end

%Creation of 2-dimensional Window
for m = -L:L
    for n = -L:L
        if n-m+L+1 > 0 && n-m+L+1 < 2*L+1
            W(m+L+1,n+L+1) = d(L+1+m)*d(L+1+n)*d(n-m+L+1);
        end
    end
end

%Depiction
figure
surf(-L:L,-L:L,W);
str=sprintf('Parzen Window: L=%d',L);
legend(str)

end