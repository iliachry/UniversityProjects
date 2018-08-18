% Exercise 1.2 (ii)

e = zeros(200,10000);
wnorm = zeros(200,10000);

for i = 1:10000
    [e(:,i), wnorm(:,i)]= RunLMS(9);
end

av_squared_error = mean(e.^2,2);
av_weight_error = mean(wnorm,2);

figure;
semilogy(av_squared_error);
ylabel('e^2')
xlabel('N')
title('LMS Average Squared Error, With 20 dB Noise');

figure;
semilogy(av_weight_error);
ylabel('Weighted Error Vector')
xlabel('N')
title('LMS Average Normalized Weighted Error Vector, With 20 dB Noise');