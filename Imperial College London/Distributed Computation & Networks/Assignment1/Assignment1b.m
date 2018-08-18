clear all; close all; clc

lambda = 0.2;
b = 0.5;
T = 10000;

B = zeros(T,1); % Number of blocked terminals
A = zeros(T,1); % Number of transmissions from active terminals
N = zeros(T-1,1); % Number of transmissions from blocked terminals 
Th = zeros(T-1,1); % The channel throughput 

a0 = exp(-lambda);
a1 = lambda*exp(-lambda);

B(1) = 500;

for i = 1:(T-1)
    b = (a0 - a1)/(a0*B(i) - a1); % optimal b
%    b = (1-lambda)/B(i); % Different Definition of the optimal b
    A(i) = poissrnd(lambda);
    for j = 1:B(i)
        if rand < b 
            N(i) = N(i) + 1;
        end
    end
    if B(i) > 0 && A(i) == 0 && N(i) == 1
        B(i+1) = B(i) - 1;
    elseif (A(i) == 1 && N(i) >= 1 && B(i) > 0) || A(i) >= 2 
        B(i+1) = B(i) + A(i) ;  
    elseif (A(i) == 0 && N(i)>=2 && B(i) >0) || (A(i) == 0 && N(i) == 0)...
            || (A(i) == 1 && N(i) == 0)
        B(i+1) = B(i);
    end
    Th(i) = a1*(1-b)^(B(i)) + a0*B(i)*b*(1-b)^(B(i)-1);
%    L = B(i)*b + lambda; 
%    Th(i) = L*exp(-L); % Different Definition of the channel throughput 
end

% figure;
% plot(A)
% title('A')
figure;
plot(B)
title('Number of Blocked Terminals')
ylabel('B');
xlabel('t')
figure;
plot(N)
title('Number of Blocked Packets')
ylabel('N');
xlabel('t')
figure; 
plot(Th)
title('Channel Throughput')
ylabel('Th');
xlabel('t')
 axis([0 T 0 1])
