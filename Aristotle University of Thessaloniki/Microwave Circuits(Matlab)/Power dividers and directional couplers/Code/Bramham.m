% Microwaves 2
% 2nd Project 

close all;
clearvars;

normFreq = 0.5:0.001:1.5;
Z1 = 50;
Z2 = 100;
r = Z2/Z1;

%lamda/4
Z0 = sqrt(Z1*Z2);
theta = pi/2*normFreq;
S11 = zeros(1, length(normFreq));
for i = 1:length(normFreq)
    ABCD = [cos(theta(i)) 1i*Z0*sin(theta(i));1i*1/Z0*sin(theta(i)) cos(theta(i))];
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    S11(i) = (A + B/Z2 - C*Z1 - D*Z1/Z2)/(A + B/Z2 + C*Z1 + D*Z1/Z2);
end

plot(normFreq, 20*log10(abs(S11)))
ylim([-50 0])

%Bramham
theta = acot(sqrt(1+r+1/r))*normFreq;
for i = 1:length(normFreq)
    ABCD1 = [cos(theta(i)) 1i*Z1*sin(theta(i));1i*1/Z1*sin(theta(i)) cos(theta(i))];
    ABCD2 = [cos(theta(i)) 1i*Z2*sin(theta(i));1i*1/Z2*sin(theta(i)) cos(theta(i))];
    ABCD = ABCD2 * ABCD1;
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    S11(i) = (A + B/Z2 - C*Z1 - D*Z1/Z2)/(A + B/Z2 + C*Z1 + D*Z1/Z2);
end
hold on;
grid on;
plot(normFreq, 20*log10(abs(S11)))

legend('lamda/4','Bramham')
ylabel('dB')
xlabel('f/f0')
title('S11')



