clear all; close all; clc

lambda = [0.1 0.3 0.5 0.7 0.9];
b = 0.5;
T = 10000;

B = zeros(T,5); % Number of blocked terminals
A = zeros(T,1); % Number of transmissions from active terminals
N = zeros(T-1,5); % Number of transmissions from blocked terminals 
Th = zeros(T-1,5); % The channel throughput 

a0 = exp(-lambda);
a1 = lambda.*exp(-lambda);

B(1,:) = 0;

for j = 1:5
    for i = 1:(T-1)

        A(i) = poissrnd(lambda(j));
        for k = 1:B(i,j)
            if rand < b 
                N(i,j) = N(i,j) + 1;
            end
        end
        if B(i,j) > 0 && A(i) == 0 && N(i,j) == 1
            B(i+1,j) = B(i,j) - 1;
        elseif (A(i) == 1 && N(i,j) >= 1 && B(i,j) > 0) || A(i) >= 2 
            B(i+1,j) = B(i,j) + A(i) ;  
        elseif (A(i) == 0 && N(i,j)>=2 && B(i,j) >0) || (A(i) == 0 && N(i,j) == 0)...
                || (A(i) == 1 && N(i,j) == 0)
            B(i+1,j) = B(i,j);
        end
        Th(i,j) = a1(j)*(1-b)^(B(i,j)) + a0(j)*B(i,j)*b*(1-b)^(B(i,j)-1);

    end
end

% figure;
% plot(A)
% title('A')

figure;
subplot(2,3,1)
plot(B)
title(['Number of Blocked Terminals, b = ' num2str(b)])
ylabel('B');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,2)
plot(N)
title(['Number of Blocked Packets, b = ' num2str(b)])
ylabel('N');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,3); 
plot(Th)
title(['Channel Throughput, b = ' num2str(b)])
ylabel('Th');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northeast')
axis([0 T 0 0.8])

b = 0.1;
T = 10000;

B = zeros(T,5); % Number of blocked terminals
A = zeros(T,1); % Number of transmissions from active terminals
N = zeros(T-1,5); % Number of transmissions from blocked terminals 
Th = zeros(T-1,5); % The channel throughput 

a0 = exp(-lambda);
a1 = lambda.*exp(-lambda);

B(1,:) = 0;

for j = 1:5
    for i = 1:(T-1)

        A(i) = poissrnd(lambda(j));
        for k = 1:B(i,j)
            if rand < b 
                N(i,j) = N(i,j) + 1;
            end
        end
        if B(i,j) > 0 && A(i) == 0 && N(i,j) == 1
            B(i+1,j) = B(i,j) - 1;
        elseif (A(i) == 1 && N(i,j) >= 1 && B(i,j) > 0) || A(i) >= 2 
            B(i+1,j) = B(i,j) + A(i) ;  
        elseif (A(i) == 0 && N(i,j)>=2 && B(i,j) >0) || (A(i) == 0 && N(i,j) == 0)...
                || (A(i) == 1 && N(i,j) == 0)
            B(i+1,j) = B(i,j);
        end
        Th(i,j) = a1(j)*(1-b)^(B(i,j)) + a0(j)*B(i,j)*b*(1-b)^(B(i,j)-1);

    end
end

% figure;
% plot(A)
% title('A')

subplot(2,3,4)
plot(B)
title(['Number of Blocked Terminals, b = ' num2str(b)])
ylabel('B');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,5)
plot(N)
title(['Number of Blocked Packets, b = ' num2str(b)])
ylabel('N');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,6); 
plot(Th)
title(['Channel Throughput, b = ' num2str(b)])
ylabel('Th');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northeast')
axis([0 T 0 0.8])


b = 0.005;
T = 10000;

B = zeros(T,5); % Number of blocked terminals
A = zeros(T,1); % Number of transmissions from active terminals
N = zeros(T-1,5); % Number of transmissions from blocked terminals 
Th = zeros(T-1,5); % The channel throughput 

a0 = exp(-lambda);
a1 = lambda.*exp(-lambda);

B(1,:) = 0;

for j = 1:5
    for i = 1:(T-1)

        A(i) = poissrnd(lambda(j));
        for k = 1:B(i,j)
            if rand < b 
                N(i,j) = N(i,j) + 1;
            end
        end
        if B(i,j) > 0 && A(i) == 0 && N(i,j) == 1
            B(i+1,j) = B(i,j) - 1;
        elseif (A(i) == 1 && N(i,j) >= 1 && B(i,j) > 0) || A(i) >= 2 
            B(i+1,j) = B(i,j) + A(i) ;  
        elseif (A(i) == 0 && N(i,j)>=2 && B(i,j) >0) || (A(i) == 0 && N(i,j) == 0)...
                || (A(i) == 1 && N(i,j) == 0)
            B(i+1,j) = B(i,j);
        end
        Th(i,j) = a1(j)*(1-b)^(B(i,j)) + a0(j)*B(i,j)*b*(1-b)^(B(i,j)-1);

    end
end

% figure;
% plot(A)
% title('A')

figure;
subplot(2,3,1)
plot(B)
title(['Number of Blocked Terminals, b = ' num2str(b)])
ylabel('B');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,2)
plot(N)
title(['Number of Blocked Packets, b = ' num2str(b)])
ylabel('N');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,3); 
plot(Th)
title(['Channel Throughput, b = ' num2str(b)])
ylabel('Th');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northeast')
axis([0 T 0 0.8])

b = 0.001;
T = 10000;

B = zeros(T,5); % Number of blocked terminals
A = zeros(T,1); % Number of transmissions from active terminals
N = zeros(T-1,5); % Number of transmissions from blocked terminals 
Th = zeros(T-1,5); % The channel throughput 

a0 = exp(-lambda);
a1 = lambda.*exp(-lambda);

B(1,:) = 0;

for j = 1:5
    for i = 1:(T-1)

        A(i) = poissrnd(lambda(j));
        for k = 1:B(i,j)
            if rand < b 
                N(i,j) = N(i,j) + 1;
            end
        end
        if B(i,j) > 0 && A(i) == 0 && N(i,j) == 1
            B(i+1,j) = B(i,j) - 1;
        elseif (A(i) == 1 && N(i,j) >= 1 && B(i,j) > 0) || A(i) >= 2 
            B(i+1,j) = B(i,j) + A(i) ;  
        elseif (A(i) == 0 && N(i,j)>=2 && B(i,j) >0) || (A(i) == 0 && N(i,j) == 0)...
                || (A(i) == 1 && N(i,j) == 0)
            B(i+1,j) = B(i,j);
        end
        Th(i,j) = a1(j)*(1-b)^(B(i,j)) + a0(j)*B(i,j)*b*(1-b)^(B(i,j)-1);

    end
end

% figure;
% plot(A)
% title('A')

subplot(2,3,4)
plot(B)
title(['Number of Blocked Terminals, b = ' num2str(b)])
ylabel('B');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,5)
plot(N)
title(['Number of Blocked Packets, b = ' num2str(b)])
ylabel('N');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northwest')

subplot(2,3,6); 
plot(Th)
title(['Channel Throughput, b = ' num2str(b)])
ylabel('Th');
xlabel('t')
legend('lambda = 0.1','lambda = 0.3','lambda = 0.5','lambda = 0.7','lambda = 0.9','Location','northeast')
axis([0 T 0 0.8])

