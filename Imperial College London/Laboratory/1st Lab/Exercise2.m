% Exercise 2
clear all
close all

m = 128;
n = 256; 
S = 12;

A = randn(m, n);
A(:,1:n) = A(:,1:n)./norm(A(:,1:n));

% for i = 1:n
%    A(:,i) = A(:,i)./norm(A(:,i),2);
% end

x_support_set = randsample(n,S);
x = normrnd(0,1,n,1);
    

for i = 1:n
    if ismember(i, x_support_set) == 0
        x(i) = 0;
    end
end

y = A*x;
y_pseudoinverse = A\y;
yp = A*y_pseudoinverse;
yr = y - yp;

x1 = pinv(A)*y;
x2 = A\y;

% OMP

xOMP = OMP(S, A, y, n);

% figure;
% subplot(2,1,1)
% plot(x)
% subplot(2,1,2)
% plot(xOMP)

%error_OMP = immse(x, xOMP);
error2_OMP = norm(xOMP - x)/norm(x);

% SP 

xSP = SP(S, A, y, n);

% figure;
% subplot(2,1,1)
% plot(x)
% subplot(2,1,2)
% plot(xSP)

%error_SP = immse(x, xSP);
error2_SP = norm(xSP - x)/norm(x);

% IHT 

xIHT = IHT(S, A, y, n);

% figure;
% subplot(2,1,1)
% plot(x)
% subplot(2,1,2)
% plot(xIHT)

%error_IHT = immse(x, xIHT);
error2_IHT = norm(xIHT - x)/norm(x);

% figure
% plot(x, 'blue');
% hold on;
% plot(xOMP, 'red');
% legend('x', 'xOMP');
% xlabel('n')
% ylabel('Amplitude')
% 
% figure
% plot(x, 'blue');
% hold on;
% plot(xSP, 'red');
% legend('x', 'xSP');
% xlabel('n')
% ylabel('Amplitude')
% 
% figure
% plot(x, 'blue');
% hold on;
% plot(xIHT, 'red');
% legend('x', 'xIHT');
% xlabel('n')
% ylabel('Amplitude')

% figure;
% subplot(6,1,1)
% plot(x)
% ylabel('x')
% xlabel('n')
% subplot(6,1,2)
% plot(x1)
% ylabel('x1')
% xlabel('n')
% subplot(6,1,3)
% plot(x2)
% ylabel('x2')
% xlabel('n')
% subplot(6,1,4)
% plot(xOMP)
% ylabel('xOMP')
% xlabel('n')
% subplot(6,1,5)
% plot(xSP)
% ylabel('xSP')
% xlabel('n')
% subplot(6,1,6)
% plot(xIHT)
% ylabel('xIHT')
% xlabel('n')

