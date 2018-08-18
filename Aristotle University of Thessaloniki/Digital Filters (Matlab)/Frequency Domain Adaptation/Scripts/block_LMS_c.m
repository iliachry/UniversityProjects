% Block LMS algorithm with FFT
% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

clear all;
close all;

n = 1500000; % time steps
T = 10; % number of independent trials
sigma2d = 0.27; % noise variance
M = 3000; % order of the filter

kmax = floor(n / M); % integral part

%% channel
result = zeros(kmax - 1);
average_J = zeros(kmax - 1,T);

for t=1:T
   
    % Generate gaussian noise with variance = 0.27
    v = randn(n, 1) * sqrt(sigma2d); 
    v = v - mean(v);

    % Generate input signal
    u = zeros(n, 1);
    u(1) = v(1);
    for i=2:n
        u(i) = (-0.18 * u(i-1)) + v(i);
    end

    d = plant(u');
    d = d';
    
    W = zeros(2*M,1);
    P = zeros(2*M,1);
    u_t = zeros(2*M,1);
    
    for k=1:kmax-1
        u_t = u((k-1)*M+1:(k+1)*M);
        u_temp = fft(u_t, 2*M);
		yzer = ifft(u_temp .* W);
		y = yzer(M+1:2*M);
		d_temp = d(k*M+1:(k+1)*M);
		e(k*M+1:(k+1)*M ,1) = d_temp - y;
        average_J(k,t) = sum(e(k*M+1:(k+1)*M,1).^2) / M;
		
		%power estimation
        forgeting_fact = 0.3; %forgetting factor
        P = forgeting_fact * P + (1-forgeting_fact) * abs(u_temp) .^ 2; %estimation of Pi
        
        %transformation of estimation error 
        Uvec = fft( [zeros(M,1)' e(k*M+1:(k+1)*M)']' ,2*M );
		
        %inverse of power
        Dvec = 1 ./ P;
		
        %gradient estimation
        fizer = ifft( Dvec .* conj(u_temp) .* Uvec ,2*M );
        fi = fizer(1:M);
		
        %update the weights
        stepsize = 0.4; %size of step
        W = W + stepsize * fft([fi;zeros(M,1)],2*M);
    end
	
    w = ifft(W);
    w = real(w(1:length(W) / 2));
    
end

for k=1:kmax-1
    result(k) = sum(average_J(k,:)) / (T - 1);
end

figure;
semilogy(result);
xlabel('k ');
ylabel('Ee^{2}(n)');
title('Learning curve ( M = 3000 )');
