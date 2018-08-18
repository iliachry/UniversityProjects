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

%S21 
figure
plot(normFreq,20*log10(abs(S1(2,:))))
hold on
plot(normFreq,20*log10(abs(S2(2,:))))
plot(normFreq,20*log10(abs(S3(2,:))))
plot(normFreq,20*log10(abs(S4(2,:))))
ylim([-10 0])
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('dB')
title('S21 Transmission Coefficient(Amplitude) of Hybrids')
grid on
%S21 Phase
figure
plot(normFreq,(180/pi)*(angle(S1(2,:))))
hold on
plot(normFreq,(180/pi)*(angle(S2(2,:))))
plot(normFreq,(180/pi)*(angle(S3(2,:))))
plot(normFreq,(180/pi)*(angle(S4(2,:))))
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('Deg')
title('S21 Transmission Coefficient(Phase) of Hybrids')
grid on
%S31
figure
plot(normFreq,20*log10(abs(S1(3,:))))
hold on
plot(normFreq,20*log10(abs(S2(3,:))))
plot(normFreq,20*log10(abs(S3(3,:))))
plot(normFreq,20*log10(abs(S4(3,:))))
ylim([-10 0])
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('dB')
title('S31 Transmission Coefficient(Amplitude) of Hybrids')
grid on
%S31 Phase
figure
plot(normFreq,(180/pi)*(angle(S1(3,:))))
hold on
plot(normFreq,(180/pi)*(angle(S2(3,:))))
plot(normFreq,(180/pi)*(angle(S3(3,:))))
plot(normFreq,(180/pi)*(angle(S4(3,:))))
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('Deg')
title('S31 transmission Coefficient(Phase) of Hybrids')
grid on

%Bandwidth
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

formatSpec1 = 'Bandwidth for Hybrid #1 equals to %5.2f%% of f0 \n';
fprintf(formatSpec1,200*(normFreq(indexes(1))-normFreq(index)))
formatSpec1 = 'Bandwidth for Hybrid #2 equals to %5.2f%% of f0 \n';
fprintf(formatSpec1,200*(normFreq(indexes(2))-normFreq(index)))
formatSpec1 = 'Bandwidth for Hybrid #3 equals to %5.2f%% of f0 \n';
fprintf(formatSpec1,200*(normFreq(indexes(3))-normFreq(index)))
formatSpec1 = 'Bandwidth for Hybrid #4 equals to %5.2f%% of f0 \n';
fprintf(formatSpec1,200*(normFreq(indexes(4))-normFreq(index)))