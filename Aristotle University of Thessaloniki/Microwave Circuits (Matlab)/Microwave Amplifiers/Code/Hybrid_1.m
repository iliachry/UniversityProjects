% Microwaves 2
% 2nd Project 

function [S] = Hybrid_1(normFreq)
Z0 = 1;
Z1 = Z0/sqrt(2);
theta1 = 2*pi*0.25*normFreq;
theta2 = theta1/2;

%Even
GammaEven = zeros(1,length(normFreq));
TEven = zeros(1,length(normFreq));
for i = 1:length(normFreq)
    ABCD1 = [1 0;(1i)*tan(theta2(i))/Z0 1];
    ABCD2 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD3 = [1 0;(1i)*tan(theta2(i))/Z0 1];
    ABCD = ABCD1*ABCD2*ABCD3;
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    GammaEven(i) = (A+B/Z0-C*Z0-D)/(A+B/Z0+C*Z0+D);
    TEven(i) = 2/(A+B/Z0+C*Z0+D);
end

%Odd
GammaOdd = zeros(1,length(normFreq));
TOdd = zeros(1,length(normFreq));
for i = 1:length(normFreq)
    ABCD1 = [1 0;1/((1i)*tan(theta2(i))*Z0) 1];
    ABCD2 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD3 = [1 0;1/((1i)*tan(theta2(i))*Z0) 1];
    ABCD = ABCD1*ABCD2*ABCD3;
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    GammaOdd(i) = (A+B/Z0-C*Z0-D)/(A+B/Z0+C*Z0+D);
    TOdd(i) = 2/(A+B/Z0+C*Z0+D);
end

S11 = 0.5*(GammaEven+GammaOdd);
S21 = 0.5*(TEven+TOdd);
S41 = 0.5*(GammaEven-GammaOdd);
S31 = 0.5*(TEven-TOdd);
S = [S11;S21;S31;S41];
end