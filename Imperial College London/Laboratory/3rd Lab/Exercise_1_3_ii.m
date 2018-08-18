% Exercise 1.3(ii)
close all;
clear all;

N = 200;

k = 1:9;
w = 1./k.*exp(-(k-4).^2/4);

lambda = [1, 0.99, 0.95, 0.8];

% 1st part: Similiar to 1.2(i)
e = zeros(200,3,4);
wnorm = zeros(200,3,4);
x = randn(N, 1);
d = filter(w,1,x);

% lambda = 1
% L = 9
L = 9;
[e(:,1,1), wmat] = RLS(x, d, lambda(1), L);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm(:,1,1) = wnm/wdn;

% L = 5
L = 5;
[e(:,2,1), wmat] = RLS(x, d, lambda(1), 5);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wmat(:,6:9) = zeros(200,4);
wnm = sum(((wmat-wi).^2)');
wnorm(:,2,1) = wnm/wdn;

% L = 11
L = 11;
[e(:,3,1), wmat] = RLS(x, d, lambda(1), 11);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wi(:,10:11) = zeros(200,2);
wnm = sum(((wmat-wi).^2)');
wnorm(:,3,1) = wnm/wdn;

figure;
semilogy(e(:,1,1).^2);
hold on;
semilogy(e(:,2,1).^2);
semilogy(e(:,3,1).^2);
legend('L = 9', 'L = 5', 'L = 11')
ylabel('e^2 [dB]')
xlabel('N')
title('RLS, l = 1')

figure;
semilogy(wnorm(:,1,1));
hold on;
semilogy(wnorm(:,2,1));
semilogy(wnorm(:,3,1));
legend('L = 9', 'L = 5', 'L = 11')
ylabel('Weighted Error Vector')
xlabel('N')
title('RLS, l = 1')

% lambda = 0.99
% L = 9
L = 9;
[e(:,1,2), wmat] = RLS(x, d, lambda(2), L);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm(:,1,2) = wnm/wdn;

% L = 5
L = 5;
[e(:,2,2), wmat] = RLS(x, d, lambda(2), 5);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wmat(:,6:9) = zeros(200,4);
wnm = sum(((wmat-wi).^2)');
wnorm(:,2,2) = wnm/wdn;

% L = 11
L = 11;
[e(:,3,2), wmat] = RLS(x, d, lambda(2), 11);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wi(:,10:11) = zeros(200,2);
wnm = sum(((wmat-wi).^2)');
wnorm(:,3,2) = wnm/wdn;

figure;
semilogy(e(:,1,2).^2);
hold on;
semilogy(e(:,2,2).^2);
semilogy(e(:,3,2).^2);
legend('L = 9', 'L = 5', 'L = 11')
ylabel('e^2 [dB]')
xlabel('N')
title('RLS, l = 0.99')

figure;
semilogy(wnorm(:,1,2));
hold on;
semilogy(wnorm(:,2,2));
semilogy(wnorm(:,3,2));
legend('L = 9', 'L = 5', 'L = 11')
ylabel('Weighted Error Vector')
xlabel('N')
title('RLS, l = 0.99')

% lambda = 0.95
% L = 9
L = 9;
[e(:,1,3), wmat] = RLS(x, d, lambda(3), L);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm(:,1,3) = wnm/wdn;

% L = 5
L = 5;
[e(:,2,3), wmat] = RLS(x, d, lambda(3), 5);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wmat(:,6:9) = zeros(200,4);
wnm = sum(((wmat-wi).^2)');
wnorm(:,2,3) = wnm/wdn;

% L = 11
L = 11;
[e(:,3,3), wmat] = RLS(x, d, lambda(3), 11);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wi(:,10:11) = zeros(200,2);
wnm = sum(((wmat-wi).^2)');
wnorm(:,3,3) = wnm/wdn;

figure;
semilogy(e(:,1,3).^2);
hold on;
semilogy(e(:,2,3).^2);
semilogy(e(:,3,3).^2);
legend('L = 9', 'L = 5', 'L = 11')
ylabel('e^2 [dB]')
xlabel('N')
title('RLS, l = 0.95')

figure;
semilogy(wnorm(:,1,3));
hold on;
semilogy(wnorm(:,2,3));
semilogy(wnorm(:,3,3));
legend('L = 9', 'L = 5', 'L = 11')
ylabel('Weighted Error Vector')
xlabel('N')
title('RLS, l = 0.95')

% lambda = 0.8
% L = 9
L = 9;
[e(:,1,4), wmat] = RLS(x, d, lambda(4), L);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm(:,1,4) = wnm/wdn;

% L = 5
L = 5;
[e(:,2,4), wmat] = RLS(x, d, lambda(4), 5);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wmat(:,6:9) = zeros(200,4);
wnm = sum(((wmat-wi).^2)');
wnorm(:,2,4) = wnm/wdn;

% L = 11
L = 11;
[e(:,3,4), wmat] = RLS(x, d, lambda(4), 11);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wi(:,10:11) = zeros(200,2);
wnm = sum(((wmat-wi).^2)');
wnorm(:,3,4) = wnm/wdn;

figure;
semilogy(e(:,1,4).^2);
hold on;
semilogy(e(:,2,4).^2);
semilogy(e(:,3,4).^2);
legend('L = 9', 'L = 5', 'L = 11')
ylabel('e^2 [dB]')
xlabel('N')
title('RLS, l = 0.8')

figure;
semilogy(wnorm(:,1,4));
hold on;
semilogy(wnorm(:,2,4));
semilogy(wnorm(:,3,4));
legend('L = 9', 'L = 5', 'L = 11')
ylabel('Weighted Error Vector')
xlabel('N')
title('RLS, l = 0.8')

% 2nd part: Similar to 1.2(ii)
e = zeros(200,20,4);
wnorm = zeros(200,20,4);

for i = 1:20
    [e(:,i,1), wnorm(:,i,1)]= RunRLS(9,0,lambda(1));
    [e(:,i,2), wnorm(:,i,2)]= RunRLS(9,0,lambda(2));
    [e(:,i,3), wnorm(:,i,3)]= RunRLS(9,0,lambda(3));
    [e(:,i,4), wnorm(:,i,4)]= RunRLS(9,0,lambda(4));
end

av_squared_error(:,1) = mean(e(:,:,1).^2,2);
av_squared_error(:,2) = mean(e(:,:,2).^2,2);
av_squared_error(:,3) = mean(e(:,:,3).^2,2);
av_squared_error(:,4) = mean(e(:,:,4).^2,2);
av_weight_error(:,1) = mean(wnorm(:,:,1),2);
av_weight_error(:,2) = mean(wnorm(:,:,2),2);
av_weight_error(:,3) = mean(wnorm(:,:,3),2);
av_weight_error(:,4) = mean(wnorm(:,:,4),2);

figure;
semilogy(av_squared_error(:,1));
hold on
semilogy(av_squared_error(:,2));
semilogy(av_squared_error(:,3));
semilogy(av_squared_error(:,4));
ylabel('Average Squared Error');
legend('l=1','l=0.99','l=0.95','l=0.8')
title('RLS, 20 realizations without Noise')

figure;
semilogy(av_weight_error(:,1));
hold on;
semilogy(av_weight_error(:,2));
semilogy(av_weight_error(:,3));
semilogy(av_weight_error(:,4));
ylabel('Average Weight Error');
legend('l=1','l=0.99','l=0.95','l=0.8')
title('RLS, 20 realizations without Noise')


% 3rd part: Similar to 1.2(iv)
e = zeros(200,20,4);
wnorm = zeros(200,20,4);

for i = 1:20
    [e(:,i,1), wnorm(:,i,1)]= RunRLS(9,0.1,lambda(1));
    [e(:,i,2), wnorm(:,i,2)]= RunRLS(9,0.1,lambda(2));
    [e(:,i,3), wnorm(:,i,3)]= RunRLS(9,0.1,lambda(3));
    [e(:,i,4), wnorm(:,i,4)]= RunRLS(9,0.1,lambda(4));
end

av_squared_error(:,1) = mean(e(:,:,1).^2,2);
av_squared_error(:,2) = mean(e(:,:,2).^2,2);
av_squared_error(:,3) = mean(e(:,:,3).^2,2);
av_squared_error(:,4) = mean(e(:,:,4).^2,2);
av_weight_error(:,1) = mean(wnorm(:,:,1),2);
av_weight_error(:,2) = mean(wnorm(:,:,2),2);
av_weight_error(:,3) = mean(wnorm(:,:,3),2);
av_weight_error(:,4) = mean(wnorm(:,:,4),2);

figure;
semilogy(av_squared_error(:,1));
hold on
semilogy(av_squared_error(:,2));
semilogy(av_squared_error(:,3));
semilogy(av_squared_error(:,4));
ylabel('Average Squared Error');
legend('l=1','l=0.99','l=0.95','l=0.8')
title('RLS, 20 realizations with 20dB Noise')

figure;
semilogy(av_weight_error(:,1));
hold on;
semilogy(av_weight_error(:,2));
semilogy(av_weight_error(:,3));
semilogy(av_weight_error(:,4));
ylabel('Average Weight Error');
legend('l=1','l=0.99','l=0.95','l=0.8')
title('RLS, 20 realizations with 20dB Noise')