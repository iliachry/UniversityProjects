%Advanced Signal Processing Techniques
%2nd Question
%5th Subquestion
%Calculate the estimation error of the input signal x in the output of the
%system in AWGN environment
function [total_errors1, total_errors2, total_errors3]  = Add_Gaussian_Noise(x, v)
initial_signal = x;
total_errors1=zeros(1,8);
total_errors2=zeros(1,8);
total_errors3=zeros(1,8);
j = 1;

for SNR = 30:-5:-5
    x = awgn(initial_signal,SNR);
    cumulants = Cumulants(x);
    [h, h1, h2] = Impulse_Response(cumulants); 
    [x1, x2, x3] = Signal_Generation(x, v, h, h1, h2);
%     figure;
%     surf(-20:20,-20:20,cumulants);
%     str = sprintf('cumulants with SNR = %d',SNR);
%     title(str);
    total_errors1(1,j) = immse(x, x1);
    total_errors2(1,j) = immse(x, x2);
    total_errors3(1,j) = immse(x, x3);
    j=j+1; 
end

% SNR = 30:-5:-5;
% figure;
% plot(SNR, total_errors1(1:end));
% figure;
% plot(SNR, total_errors2(1:end));
% figure;
% plot(SNR, total_errors3(1:end));

end
