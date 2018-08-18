% Block LMS algorithm with two nested loops
% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

clear all;
close all;

n = 1500000; % time steps
T = 10; % number of independent trials
sigma2d = 0.27; % noise variance
M = 3000; % order of the filter

k_max = floor(n / M); % integral part

%% channel
mu = 0.0005;
mtrials = length(mu);
result = zeros(k_max - 1, size(mu,2));

%% adaptation
for mi=1:mtrials
    
    average_J = zeros(k_max - 1,T); % Average errors for Graph
    
    for t=1:T

        v = sqrt(sigma2d) * randn(n, 1) ; % Generate gaussian noise with variance = 0.27
        v = v - mean(v);
    
        % Generate input signal
        u = zeros(n, 1);
        u(1) = v(1);
        for i=2:n
            u(i) = (-0.18 * u(i-1)) + v(i);
        end
        
        %initialize
        w = zeros(M, 1);
        y = zeros(n, 1);
        e = zeros(n, 1);
        d = plant(u');
        d = d';
        
        for k=1:k_max-1
            fi = zeros(M,1);
            u_temp = zeros(M,1);
            for i=1:M-1 
                u_temp = u(k*M+i:-1:k*M+i-M+1);
                d_temp = d(k*M+i);
                y = w' * u_temp;
                e = d_temp - y;
                fi = fi + (mu(mi) * e * u_temp);
                average_J(k,t) = average_J(k,t) + (e * e);
            end
            average_J(k,t) = average_J(k,t) / M;
            w = w + fi;
        end 
        
    end
    
    for k=1:k_max-1
        result(k,mi) = sum(average_J(k,:)) / (T - 1); 
    end
    
end

figure;
semilogy(result);
xlabel('k');
ylabel('Ee^{2}(n)');
legend({sprintf('mu=%f',mu)});
title('Learning curve ( M = 3000 )');
