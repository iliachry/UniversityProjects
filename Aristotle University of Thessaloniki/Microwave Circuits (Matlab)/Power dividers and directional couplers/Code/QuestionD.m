% Microwaves 2
% 2nd Project 

clearvars
close all
normFreq = 0.5:0.001:1.5;

% S parameters for each Hybrid
S1 = Hybrid_1(normFreq);
S2 = Hybrid_2(normFreq);
S3 = Hybrid_3(normFreq);
S4 = Hybrid_4(normFreq);

%S41
S41=[20*log10(abs(S1(4,:)));20*log10(abs(S2(4,:)));20*log10(abs(S3(4,:)));20*log10(abs(S4(4,:)))];
figure
plot(normFreq,S41(1,:))
hold on
plot(normFreq,S41(2,:))
plot(normFreq,S41(3,:))
plot(normFreq,S41(4,:))
ylim([-50 0])
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('dB')
title('S41 Transmission Coefficient of Hybrids')
grid on

% Isolation Maximum
S21 = [20*log10(S1(2,:)); 20*log10(S2(2,:)); 20*log10(S3(2,:)); 20*log10(S4(2,:))];
S31 = [20*log10(S1(3,:)); 20*log10(S2(3,:)); 20*log10(S3(3,:)); 20*log10(S4(3,:))];
upper_bound = -3.25;
lower_bound = -2.75;
indexes = zeros(1,4);
index = (length(normFreq)+1)/2;

for i = index:length(normFreq)
    if ((S21(1,i)<upper_bound || S21(1,i)>lower_bound)||(S31(1,i)<upper_bound || S31(1,i)>lower_bound)) && indexes(1)==0
        indexes(1) = i;
    end
    if ((S21(2,i)<upper_bound || S21(2,i)>lower_bound)||(S31(2,i)<upper_bound || S31(2,i)>lower_bound)) && indexes(2)==0
        indexes(2) = i;
    end
    if ((S21(3,i)<upper_bound || S21(3,i)>lower_bound)||(S31(3,i)<upper_bound || S31(3,i)>lower_bound)) && indexes(3)==0
        indexes(3) = i;
    end
    if ((S21(4,i)<upper_bound || S21(4,i)>lower_bound)||(S31(4,i)<upper_bound || S31(4,i)>lower_bound)) && indexes(4)==0
        indexes(4) = i;
    end
end

max=[-Inf -Inf -Inf -Inf];
for k=1:4
    for j=index:indexes(k)
        if S41(k,j)>max(k)
            max(k)=S41(k,j);
        end
    end
end