% Exercise 1.2 (i)
e = zeros(200,3);
wnorm = zeros(200,3);

% Run LMS for L = 9, L = 5 and L = 11.
% Do not use RunLms! Do not want to have different generations of x. 
N = 200;

k = 1:9;
w = 1./k.*exp(-(k-4).^2/4);

x = randn(N, 1);
d = filter(w,1,x);

% L = 9
L = 9;
mu_upper_bound = 1/L/std(x);
mu(1) = 1/3 * mu_upper_bound;
[e(:,1), wmat] = LMS(x, d, mu(1), L);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm(:,1) = wnm/wdn;

figure;
scatter(1:9,wmat(200,:),100);
hold on;
scatter(1:9,w,200);
title('Final weight vector fot the Adaptive filter')
legend('wmat','w');
xlabel('k')

% L = 5
L = 5;
mu_upper_bound = 1/L/std(x);
mu(2) = 1/3 * mu_upper_bound;
[e(:,2), wmat] = LMS(x, d, mu(2), 5);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wmat(:,6:9) = zeros(200,4);
wnm = sum(((wmat-wi).^2)');
wnorm(:,2) = wnm/wdn;

% L = 11
L = 11;
mu_upper_bound = 1/L/std(x);
mu(3) = 1/3 * mu_upper_bound;
[e(:,3), wmat] = LMS(x, d, mu(3), 11);
wdn = w*w';
temp = ones(200,1);
wi = temp*w;
wi(:,10:11) = zeros(200,2);
wnm = sum(((wmat-wi).^2)');
wnorm(:,3) = wnm/wdn;

figure;
plot(e(:,1).^2);
hold on;
plot(e(:,2).^2);
plot(e(:,3).^2);
legend(['L = 9, mu = ' num2str(mu(1))], ['L = 5, mu = ' num2str(mu(2))], ['L = 11, mu = ' num2str(mu(3))])
ylabel('e^2')
xlabel('N')
title('LMS Squared Error');

figure;
semilogy(e(:,1).^2);
hold on;
semilogy(e(:,2).^2);
semilogy(e(:,3).^2);
legend(['L = 9, mu = ' num2str(mu(1))], ['L = 5, mu = ' num2str(mu(2))], ['L = 11, mu = ' num2str(mu(3))])
legend('Location', 'southwest')
ylabel('e^2 [dB]')
xlabel('N')
title('LMS Squared Error log-scale')

figure;
semilogy(wnorm(:,1));
hold on;
semilogy(wnorm(:,2));
semilogy(wnorm(:,3));
legend(['L = 9, mu = ' num2str(mu(1))], ['L = 5, mu = ' num2str(mu(2))], ['L = 11, mu = ' num2str(mu(3))])
legend('Location', 'southwest')
ylabel('Weighted Error Vector')
xlabel('N')
title('LMS Normalized Weighted Error Vector');