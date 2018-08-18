% Gamblers Ruin Probabilty as a function of his Starting Wealth %
clc; clear all; close all;
ret_zero=zeros(1,19);
N=20;
P=0.75; % set to 0.5 and 0.75
reps=1000; % No. of Simulations per i
for i=1:19 % Gambler's Initial Fortune
for k=1:reps
start_money=i;
while(start_money>0 && start_money<N)
Z = (rand < P);
Z = 2*Z - 1;
start_money= start_money+Z;
end
if start_money == 0
ret_zero(i)=ret_zero(i)+1;
end
end
if P==0.5
theo_ruin(i)=((N-i)/20);
else
theo_ruin(i)=((1-(P/(1-P))^(20-i))/(1-(P/(1-P))^20));
end
end
actual_pruin=ret_zero/reps;
figure;
plot(actual_pruin,'o','LineStyle','--') % Plot of Actual Ruin Probabilities vs gambler’s initial capital i
hold on
plot(theo_ruin,'x','LineStyle','-') % Plot of Theoretical Ruin Probabilities vs gambler’s initial capital i
grid
title(['Ruin Probabilities as a function of gambler’s initial capital i for p = ',num2str(P)]);
xlabel('i');
ylabel('Probability');
%legend('Location', 'southwest')
legend('Simulated','Theoretical');
