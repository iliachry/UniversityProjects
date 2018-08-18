% Block LMS algorithm with one loop and matrix operations
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
        
        v = randn(n, 1) * sqrt(sigma2d); % Generate gaussian noise with variance = 0.27
        v = v - mean(v);
    
        % Generate input signal
        u = zeros(n, 1);
        u(1) = v(1);
        for i=2:n
            u(i) = (-0.18 * u(i-1)) + v(i);
        end
        
        % initialize
        w = zeros(M, 1);
        y = zeros(n, 1);
        e = zeros(n, 1);
        u_temp = zeros(M,M);
        d = plant(u');
        d = d';
        
        for k=1:k_max-1
            for m=0:M-1
                u_temp(m + 1,:) = u((k * M) + m:-1:((k * M) + m - M + 1));
            end
            d_temp = d(k*M:1:(k+1)*M-1);
            y = u_temp * w;
            e = d_temp - y;
            fi = mu(mi) * u_temp' * e;
            w = w + fi;
            average_J(k, t) = sum(e .* e) / M;
        end
        
    end
    
    for k=1:k_max-1
        result(k,mi) = sum(average_J(k,:)) / (T - 1); 
    end
    
end

figure;
semilogy(result);
xlabel('k ');
ylabel('Ee^{2}(n)');
legend({sprintf('mu=%f',mu)});
title('Learning curve ( M = 3000 )');
