% Microwaves 2
% 2nd Project 

function [S] = Hybrid_3(f)
Z0 = 1;
Z1 = 1/sqrt(2);
Z2 = sqrt(2)+1;
theta1 = 2*pi*0.25*f;
theta2 = theta1/2;

%Even
GammaEven = zeros(1,length(f));
TEven = zeros(1,length(f));
for i = 1:length(f)
    ABCD1 = [1 0;(1i)*tan(theta2(i))/Z2 1];
    ABCD2 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD3 = [1 0;(1i)*tan(theta2(i))/Z1 1];
    ABCD4 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD5 = [1 0;(1i)*tan(theta2(i))/Z2 1];
    ABCD = ABCD1*ABCD2*ABCD3*ABCD4*ABCD5;
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    GammaEven(i) = (A+B/Z0-C*Z0-D)/(A+B/Z0+C*Z0+D);
    TEven(i) = 2/(A+B/Z0+C*Z0+D);
end

%Odd
GammaOdd = zeros(1,length(f));
TOdd = zeros(1,length(f));
for i = 1:length(f)
    ABCD1 = [1 0;1/((1i)*tan(theta2(i))*Z2) 1];
    ABCD2 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD3 = [1 0;1/((1i)*tan(theta2(i))*Z1) 1];
    ABCD4 = [cos(theta1(i)) (1i)*Z1*sin(theta1(i));((1i)/Z1)*sin(theta1(i)) cos(theta1(i))];
    ABCD5 = [1 0;1/((1i)*tan(theta2(i))*Z2) 1];
    ABCD = ABCD1*ABCD2*ABCD3*ABCD4*ABCD5;
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