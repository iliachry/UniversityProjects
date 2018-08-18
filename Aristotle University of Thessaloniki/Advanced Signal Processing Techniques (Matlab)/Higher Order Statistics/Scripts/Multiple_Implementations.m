
% %Skewness Iteration
% N = 100000;
% skewness = zeros(1,N);
% 
% for i = 1:1:N
%     skewness(i) = Skewness();
% end
% 
% plot(skewness);
% mean(skewness)

% %Cumulants Iterations
% N = 200;
% cumulants = zeros(41, 41);
% 
% for i = 1:1:N
%     %Input of the system, created by exponential distribution with mean = 1
%     v = exprnd(1,1,2048);
% 
%     %The MA filter coefficients
%     h = [1.0 0.91 0.81 -0.7 0.57 -0.10];
% 
%     %Generating the x signal
%     x = filter(h,1,v);
%     
%     %Cumulants Calculation
%     cumulants = cumulants + Cumulants(x);
% end
% cumulants = cumulants / N;
% surf(-20:20,-20:20,cumulants);
% legend('Cumulants');

% %Impulse Response Iteration 
% N = 50;
% H = zeros(1,6);
% H1 = zeros(1,4);
% H2 = zeros(1,8);
% for i = 1:1:N
%     %Input of the system, created by exponential distribution with mean = 1
%     v = exprnd(1,1,2048);
% 
%     %The MA filter coefficients
%     h = [1.0 0.91 0.81 -0.7 0.57 -0.10];
% 
%     %Generating the x signal
%     x = filter(h,1,v);
%     
%     %Cumulants Calculation
%     cumulants = Cumulants(x);
%     [h, h1, h2] = Impulse_Response(cumulants);
%     
%     H = H + h;
%     H1 = H1 + h1;
%     H2 = H2 +h2;
% end
% H = H / N;
% H1 = H1 / N;
% H2 = H2 / N;
% 
% %Signal Generation Iteration
% 
% [x1, x2, x3, e1, e2, e3] = Signal_Generation(x, v, H, H1, H2);

%Add Gaussian Noise Iteration

N = 50;
e1 = zeros(1,8);
e2 = zeros(1,8);
e3 = zeros(1,8);

for i = 1:1:N
    %Input of the system, created by exponential distribution with mean = 1
    v = exprnd(1,1,2048);

    %The MA filter coefficients
    h = [1.0 0.91 0.81 -0.7 0.57 -0.10];

    %Generating the x signal
    x = filter(h,1,v);
    
    [total_errors1, total_errors2, total_errors3]  = Add_Gaussian_Noise(x, v);
    
    e1 = e1 + total_errors1;
    e2 = e2 + total_errors2;
    e3 = e3 + total_errors3;    
end
e1 = e1 / N;
e2 = e2 / N;
e3 = e3 / N;
SNR = 30:-5:-5;
figure;
plot(SNR, total_errors1(1:end));
figure;
plot(SNR, total_errors2(1:end));
figure;
plot(SNR, total_errors3(1:end));


    
