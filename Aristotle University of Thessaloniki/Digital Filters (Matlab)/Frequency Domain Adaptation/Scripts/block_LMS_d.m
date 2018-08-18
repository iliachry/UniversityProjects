% Block LMS algorithm with unconstrained adaptation on the frequency domain
% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

clear all;
close all;

kmax=1000;
L=3000; %order of the filter
W(1:2*L)=0;
u=temp(1,kmax*L,0.27);
d=plant(u);

average_J= zeros(kmax,1);

for k=2:kmax

    if k==2
    p=var(u((k-1)*L+1:k*L))*autocorr(u((k-1)*L+1:k*L),L-1);
    mu=0.4*(2/(L*eigs(toeplitz(p),1,'la')));
    end

    z=fft(u((k-2)*L+1:k*L));
    o=ifft(z.*W);
    y=o(L+1:2*L);
    e=d((k-1)*L+1:k*L)-y;
    E=fft([zeros(1,L) e]);
    W=W+mu*conj(z).*E;
    average_J(k)=sum(e.^2);

end

figure
semilogy(average_J)
title('Learning curve ( M = 3000 )')
xlabel('k')
ylabel('Ee^{2}(n)')

