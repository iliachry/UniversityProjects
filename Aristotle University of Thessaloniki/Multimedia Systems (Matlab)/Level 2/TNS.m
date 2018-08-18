function [frameFout, TNScoeffs] = TNS(frameFin, frameType)
% in
% frameFin: The MDCT coefficients before the Temporal Noise Shaping(TNS) 
%           process, 128*8 if EIGHT SHORT SEQUENCE, 1024*1 otherwise
% frameType: The type of the frame 
%
% out
% frameFout: The MDCT coefficients after the Temporal Noise Shaping(TNS) 
%            process, 128*8 if EIGHT SHORT SEQUENCE, 1024*1 otherwise
% TNScoeffs: The quantized TNS coefficients, 4*8 if EIGHT SHORT SEQUENCE, 
%            4*1 otherwise

B=load('TableB219.mat'); % load the psychoacoustic model's bands 
B219a=B.B219a;
B219b=B.B219b;

order = 4; % the order of the filter(the number of the TNS coefficients

% Different implementation for EIGHT SHORT SEQUENCE type of frame or else
if strcmp(frameType,'ESH')~=1
    NB = length(B219a(:,1)); % Number of bands (69 here)
    b = B219a(:,2); % Starting points for each band
    b(70) = 1024; 
    
    % Calculating the normalization coefficients      
    P = zeros(1, NB); % Initializing the Band's Energy Matrix 
    Sw = zeros(1, 1024); % Initializing the normalization coefficients
    for j = 1:1:NB
        for k = (b(j)+1):1:b(j+1) 
            P(j) = P(j) + frameFin(k)^2;
        end
        
        for k = (b(j)+1):1:b(j+1)
            Sw(k) = sqrt(P(j));
        end
    end
    
    % Smoothing the normalization coefficients
    for k = 1023:-1:1
        Sw(k) = (Sw(k) + Sw(k+1))/2;
    end
    for k = 2:1:1024
         Sw(k) = (Sw(k) + Sw(k-1))/2;
    end
    
    % Normalizing the MDCT coefficients
    Xw = zeros(1, 1024);
    for k = 1:1:1024
        Xw(k) = frameFin(k) / Sw(k);
    end
   
    % Calculating the TNS coefficients 
    % The xcorr function give us a 2*order+1 matrix. We must keep only the 
    % r(0), r(1), ... r(order) values that we are going to use for the 
    % Wiener coefficients calculation. In the R matrix we just need the 
    % r(0),..., r(order-1), while in the r vector we need the r(1),..., 
    % r(order). The vector a give us the optimal Wiener coefficients.
    
    r = xcorr(Xw, Xw, order, 'unbiased');
    r = r(order + 1:(2*order + 1));
    R = toeplitz(r(1:order));
    r = r(2:order+1);
    a = R\r';
    
    % Quantize the TNS coefficients with a symmetric uniform quantizer
    a=quantizer(a);
    
    % Filtering the MDCT coefficients 
    % Stability Check: The H(z) filter is stable because it is an FIR 
    % filter. The inverse filter is not stable for sure, so we must check
    % it. We check the poles of the inverse filter. They must lay inside
    % the unitary cicle. If else, we must change the value of the pole.
    [z, p, k] = tf2zpk(1, [1 -a(1) -a(2) -a(3) -a(4)]);
    for i = 1:length(p)
        if abs(p(i)) > 1
            p(i) = 1/p(i);
        end
    end
    [c,~] = zp2tf(p,z , k);
    c= -c(2:length(c));
    c=quantizer(c);    
    TNScoeffs = c';
    frameFout = filter([1 -c(1) -c(2) -c(3) -c(4)], 1, frameFin); %filter the MDCT coeffs

else
    NB = length(B219b(:,1)); % Number of bands (42 here)
    b = B219b(:,2); % Starting points for each band
    b(43) = 128;
    
    % Calculating the normalization coefficients
    P = zeros(NB, 8); % Initializing the Band's Energy Matrix 
    Sw = zeros(128, 8); % Initializing the normalization coefficients
    for i = 1:1:8
        for j = 1:1:NB
            for k = (b(j)+1):1:b(j+1)
                P(j, i) = P(j, i) + frameFin(k, i)^2;
            end
            
            for k = (b(j)+1):1:b(j+1)
                Sw(k, i) = sqrt(P(j, i));
            end
        end
    end
    
    % Smoothing the normalization coefficients
    for i = 1:1:8
        for k = 127:-1:1
            Sw(k, i) = (Sw(k, i) + Sw(k+1, i))/2;
        end
        for k = 2:1:128
            Sw(k, i) = (Sw(k, i) + Sw(k-1, i))/2;
        end
    end
   
    % Normalizing the MDCT coefficients
    Xw = zeros(128, 1);
    for i = 1:1:8
        for k = 1:1:128
            Xw(k, i) = frameFin(k, i) / Sw(k, i);
        end
    end
    
    % Calculating the TNS coefficients 
    % The xcorr function give us a 2*order+1 matrix. We must keep only the 
    % r(0), r(1), ... r(order) values that we are going to use for the 
    % Wiener coefficients calculation. In the R matrix we just need the 
    % r(0),..., r(order-1), while in the r vector we need the r(1),..., 
    % r(order). The vector a give us the optimal Wiener coefficients.
    a = zeros(8, order);
    for i = 1:1:8
        r = xcorr(Xw(:, i), Xw(:, i), order, 'unbiased');
        r = r(order + 1:(2*order + 1));
        R = toeplitz(r(1:order));
        r = r(2:order+1);
        a(i, :) = R\r;
    end
    
    % Quantize the TNS coefficients 
    for j = 1:1:8
        a(j,:)=quantizer(a(j,:));
    end
    
    % Filtering the MDCT coefficients 
    % Stability Check: The H(z) filter is stable because it is an FIR 
    % filter. The inverse filter is not stable for sure, so we must check
    % it. We check the poles of the inverse filter. They must lay inside
    % the unitary cicle. If else, we must change the value of the pole.
    TNScoeffs = zeros(4, 8);
    frameFout = zeros(128, 8);
    for i = 1:1:8
        [z, p, k] = tf2zpk(1, [1 -a(i,1) -a(i,2) -a(i,3) -a(i,4) ]);
        for j = 1:4
            if abs(p(j)) > 1
                p(j) = 1/p(j);
            end
        end
        [c_temp, ~] = zp2tf(p, z, k);
        c_temp = -c_temp(2:5);
        c_temp = quantizer(c_temp);
        TNScoeffs(:,i) = c_temp';
        frameFout(:, i) = filter([1 -c_temp], 1, frameFin(:, i)); %filter the MDCT coeffs
    end 
end
end