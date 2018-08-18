%% 2.3.c

clear all; close all; clc;

load('PCAPCR.mat');

r = 3;
[U,S,V] = svd(Xnoise);

Xnoise_2 = U(1:1000,1:r)*S(1:r,1:r)*V(1:10,1:r)';

B_OLS = (Xnoise'*Xnoise)\Xnoise'*Y;
B_PCR = V(:,1:r)*S(1:r,1:r)^(-1)*U(:,1:r)'*Y;

Y_OLS = Xnoise*B_OLS;
Y_PCR = Xnoise_2*B_PCR;

error1 = immse(Y, Y_OLS);
error2 = immse(Y, Y_PCR);

[U,S,V] = svd(Xtest);

Xtest_2 = U(1:1000,1:r)*S(1:r,1:r)*V(1:10,1:r)';

Y_test_OLS  = Xtest*B_OLS;
Y_test_PCR = Xtest_2*B_PCR;

error3 = immse(Ytest, Y_test_OLS);
error4 = immse(Ytest, Y_test_PCR);

error5 = 0;
error6 = 0;
for i = 1:1000
    [Y_OLS_est, Y_OLS] = regval(B_OLS);
    [Y_PCR_est, Y_PCR] = regval(B_PCR);

    error5 = error5 + immse(Y_OLS_est, Y_OLS);
    error6 = error6 + immse(Y_PCR_est, Y_PCR);
end
error5 = error5/1000;
error6 = error6/1000;

