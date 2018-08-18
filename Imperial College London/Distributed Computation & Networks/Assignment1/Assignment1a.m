clear all; close all; clc;

L = 0:0.01:10;
P_sil = exp(-L);
P_succ = L.*exp(-L);
d_P_succ = exp(-L) - L.*exp(-L);
P_col = 1 - L.*exp(-L)-exp(-L);
d_P_col = -exp(-2*L)+L.^2.*exp(-L);


subplot(1,2,1)
plot(L,P_succ);
title('Probability of Success')
ylabel('Prob[Success]')
xlabel('L')
subplot(1,2,2);
plot(L,P_col)
title('Probability of Collision')
ylabel('Prob[Collision]')
xlabel('L')

