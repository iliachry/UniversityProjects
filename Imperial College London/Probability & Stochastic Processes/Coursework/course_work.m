close all;
clear all;
%% Maths course work Question 2b. Part II
fd=0.3; % Normalised Doppler Frequency
n=20;
R=zeros((n),n); 
r=zeros((n),1);
r0=besselj(0,0);

for p=1:n
R=zeros((p),p);
r=zeros((p),1);  
for i=1:p
    r(i,1)=besselj(0,2*pi*fd*(p-(i-1))); 
    for j=1:p
        R(i,j)=besselj(0,2*pi*fd*((i-j)));
    end
end
Sigma_n2(1,p)=r0-r'*(R\r);
end
plot(1:n,Sigma_n2)
xlabel('n');
ylabel('MSE');
title(' Linear MMSE estimator')
