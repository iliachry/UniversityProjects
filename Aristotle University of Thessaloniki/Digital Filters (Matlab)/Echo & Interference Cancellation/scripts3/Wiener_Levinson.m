%Digital Filters : 3rd exercise 1st part
%
%Chrysovergis Ilias
%8009
%iliachry@ece.auth.gr

close all
clear all

%Parameters and signals 

num = 10000;
n = 1:num;
f0 = 1/4;
phi = pi/2;
A = 2.3;
delta = 10;
x = A*(sin(2*pi*f0*n+phi)+cos(4*pi*f0*n+phi)+cos(7*pi*f0*n+phi/3)); %periodic interference 
v = sqrt(0.34) * randn(1,num); % transmitted signal 
v = v - mean(v); 
d = x+v; % received signal
u(n+delta)=d(n);
M = 100; %filter order

%Wiener Filter

corr = var(d)*autocorr(d,M-1);
R = toeplitz(corr);
P(1) = 0.34; 
P(2:M) = 0;
w0 = R\P';
y = filter(w0,1,u(delta+1:size(u,2)));
semilogy((y-v).^2)
hold on

%Levinson - Durbin

corr = var(d)*autocorr(d,M-1);
[a,fpp,p] = LevinsonDurbin(M-1,corr'); % forpredpower is the forward prediction power
[a_iter,~,L,Dp]= LevinsonDurbin_iterative(M-1, corr'); % iterative version of LD algorithm 
e(1:M-1) = 0;
for j = 0:M-1
    [al,e(j+1)] = levinson(corr',j); % MATLAB's LD function
end
al=al';

%Error
fprintf('MATLABs Levinson (recursive) VS Ours  %e\n',norm(a - al)) 
fprintf('MATLABs Levinson (iterative) VS Ours %e\n', norm(a_iter - al))
fprintf('Difference between gama coefficients and Wiener %e\n', norm(((L')*al)'-w0'))
fprintf('Difference of Matlab backward errors and Ours %e\n', norm(e-Dp'))

%filter output
y1=filter(a,1,u(delta+1:size(u,2)));
hold on
semilogy((y1-v).^2,'g')

title('Square Error')
xlabel('n')
ylabel('square error')
legend('Wiener','Estimator')
