% Exercise 1
close all;
clear all;

m = 128;
n = 256;

A = randn(m, n);
for i = 1:n
   A(:,i) = A(:,i)./norm(A(:,i),2);
end
x = randn(n,1);

y = A*x;

x1 = pinv(A)*y;
x2 = A\y;

subplot(3,1,1)
plot(x)
title('Initial Signal')
subplot(3,1,2)
plot(x1)
title('First Estimation')
subplot(3,1,3)
plot(x2)
title('Second Estimation')

error1 = norm(x-x1)/norm(x);
error2 = norm(x-x2)/norm(x);

figure
plot(abs(x-x1).^2/norm(x));
title('Normalized Error, Using pinv(A)*y')
xlabel('n')
ylabel('Error')
figure
plot(abs(x-x2).^2/norm(x));
title('Normalized Error, Using A\y')
xlabel('n')
ylabel('Error')
