% Microwaves 2
% 2nd Project 

close all;
clearvars;

normFreq = 0.5:0.001:1.5;

% Constants & Variables
Z0 = sqrt(2);
Z1 = 1;
Z2 = 2;
theta = pi/2*normFreq;

%S11
Zin = 1/2*Z0*(1+(1i)*Z0*tan(theta))./(Z0+(1i)*tan(theta));
S11 = (Zin-1)./(Zin+1);
plot(normFreq, 20*log10(abs(S11)))
hold on
grid on
ylim([-40 0])

%S21
S21 = zeros(1, length(normFreq));
for i = 1:length(normFreq)
    ABCD = [cos(theta(i)) 1i*Z0*sin(theta(i));1i/Z0*sin(theta(i)) cos(theta(i))];
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    S21(i) = 2*Z1/Z2/(A + B/Z2 + C*Z1 + D*Z1/Z2);
end
plot(normFreq, 20*log10(abs(S21)))

%S22
ZinEven = Z0*(Z2+1i*Z0*tan(theta))./(Z0+1i*Z2*tan(theta));
ZinOdd = 1i*Z0*tan(theta)./(1i*Z0*tan(theta)+1);
S22 = 1/2*((ZinEven-1)./(ZinEven+1)+(ZinOdd-1)./(ZinOdd+1));
plot(normFreq, 20*log10(abs(S22)))

%S32
GammaEven = (ZinEven-1)./(ZinEven+1);
GammaOdd =(ZinOdd-1)./(ZinOdd+1);
S32 = 0.5*(GammaEven - GammaOdd);
plot(normFreq, 20*log10(abs(S32)))
ylabel('dB')
xlabel('f/f0')
title('S Parameters for Wilkinson Power Divider')
legend('S11','S21','S22','S32')

%Bandwidth
index1 = (length(normFreq)+1)/2;
index2 = 0;
for i = 1:index1
    if 20*log10(abs(S32(i)))>-20
        index2 = i;
    end
end
BW = 200*(normFreq(index1)-normFreq(index2));


