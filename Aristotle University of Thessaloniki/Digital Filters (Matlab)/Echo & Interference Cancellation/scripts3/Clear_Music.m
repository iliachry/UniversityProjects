%Digital Filters : 3rd exercise 1st part
%
%Chrysovergis Ilias
%8009
%iliachry@ece.auth.gr

clear all
load('music.mat')

% Initialization

delta = 100; 
order = 100;

% joint process estimator

corr_vector = var(s)*autocorr(s,order-1);
a = LevinsonDurbin(order-1,corr_vector); % of the many outputs we only need the first one
n = 1:size(s,1);
s = s';
u(n+delta) = s(n);
y1 = filter(a,1,u);
sound(20*y1,fs)
