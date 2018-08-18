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

%S11
figure
plot(normFreq,20*log10(abs(S1(1,:))))
hold on
plot(normFreq,20*log10(abs(S2(1,:))))
plot(normFreq,20*log10(abs(S3(1,:))))
plot(normFreq,20*log10(abs(S4(1,:))))
ylim([-50 0])
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
ylabel('dB')
title('Reflection Coefficients of Hybrids')
grid on

%VSWR
VSWR(1,:) = (1+(abs(S1(1,:))))./(1-(abs(S1(1,:))));
VSWR(2,:) = (1+(abs(S2(1,:))))./(1-(abs(S2(1,:))));
VSWR(3,:) = (1+(abs(S3(1,:))))./(1-(abs(S3(1,:))));
VSWR(4,:) = (1+(abs(S4(1,:))))./(1-(abs(S4(1,:))));
VSWRlim = 1.2;

figure
plot(normFreq,VSWR(1,:))
hold on
plot(normFreq,VSWR(2,:))
plot(normFreq,VSWR(3,:))
plot(normFreq,VSWR(4,:))
plot(normFreq,VSWRlim*ones(1,length(normFreq)))
legend('Hybrid #1','Hybrid #2','Hybrid #3','Hybrid #4')
xlabel('f/f0')
title('VSWR in port 1')
grid on

%Bandwidth Calculation
index = (length(normFreq)+1)/2;
indexes = zeros(1,4);
for i = index:length(normFreq)
    if VSWR(1,i) > VSWRlim && indexes(1) == 0
        indexes(1) = i;
    end
    if VSWR(2,i)>VSWRlim && indexes(2) == 0
        indexes(2) = i;
    end
    if VSWR(3,i) > VSWRlim && indexes(3) == 0
        indexes(3) = i;
    end
    if VSWR(4,i) > VSWRlim && indexes(4) == 0
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
