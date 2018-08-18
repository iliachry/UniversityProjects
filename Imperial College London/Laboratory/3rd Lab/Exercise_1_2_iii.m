% Exercise 1.2 (iii)

e = zeros(200,20,3);
wnorm = zeros(200,20,3);

mu = [0.05, 0.01, 0.001];

for i = 1:20
    [e(:,i,1), wnorm(:,i,1)]= RunLMS_mu_given(9, mu(1));
    [e(:,i,2), wnorm(:,i,2)]= RunLMS_mu_given(9, mu(2));
    [e(:,i,3), wnorm(:,i,3)]= RunLMS_mu_given(9, mu(3));
end

av_squared_error(:,1) = mean(e(:,:,1).^2,2);
av_weight_error(:,1) = mean(wnorm(:,:,1),2);
av_squared_error(:,2) = mean(e(:,:,2).^2,2);
av_weight_error(:,2) = mean(wnorm(:,:,2),2);
av_squared_error(:,3) = mean(e(:,:,3).^2,2);
av_weight_error(:,3) = mean(wnorm(:,:,3),2);

figure;
semilogy(av_squared_error(:,1));
hold on;
semilogy(av_squared_error(:,2));
semilogy(av_squared_error(:,3));
legend('mu = 0.05', 'mu = 0.01', 'mu = 0.001')
legend('Location','southwest')
ylabel('e^2')
xlabel('N')
title('LMS Average Squared Error, Different mu');

figure;
semilogy(av_weight_error(:,1));
hold on;
semilogy(av_weight_error(:,2));
semilogy(av_weight_error(:,3));
legend('mu = 0.05', 'mu = 0.01', 'mu = 0.001') 
legend('Location','southwest')
ylabel('Weighted Error Vector')
xlabel('N')
title('LMS Average Normalized Weighted Error Vector, Different mu');

