clear all; close all; clc;

N=10000;                            % number of time slots (in seconds)
lamda=0.2;                         % the rate of arrivals of fresh packets
a0=exp(-1*lamda);             % probability of 0 fresh arrivals 
a1=lamda*exp(-1*lamda);  % probability of 1 fresh arrival 
Bupd=zeros(N,1);               % at first, the number of blocked terminals is equal to 0
% for i=1:N
%     Bupd(i)=1000;                 % at first, we assume that the number of blocked terminals is equal to 1000
% end
throupt=zeros(N,1);            % initialize
b=zeros(N,1);                     % the probability of transmission of a blocked terminal 
b(1)=1;                             % initial value of the re-transmission probability

Bupd(1) = 1000;

for t=1:N                % each iteration represents one time slot--we assume that each iteration lasts 1 second
    
    num_of_fresh_arrivals=poissrnd(lamda);      % external arrivals with a rate of lamda
    
    if Bupd(t)==0
        b(t)=b(1);                % if there aren't any blocked terminals yet, keep the initial value of b
    else
        b(t)=(a0-a1)/(a0*Bupd(t)-a1);  % adjusting the re-transmission probability
    end
    
    out = randsrc(1,Bupd(t),[0 1; (1-b(t)) b(t)]);    % a vector of length Bupd of zeros and ones
    inds=find(out~=0);  % in vector out, the elements with value of 1 are the blocked terminals that are re-transmitting  (this happens with probability b)
    num_of_blocked_arrivals=length(inds);         % we count the number of 1s in vector out
    
    throupt(t)=a1*(1-b(t))^Bupd(t)+a0*Bupd(t)*b(t)*(1-b(t))^(Bupd(t)-1);   % throughput of the channel
    
    if num_of_fresh_arrivals==0 && num_of_blocked_arrivals==1 && Bupd(t)>0
        Bupd(t+1)=Bupd(t)-1;
    elseif (num_of_fresh_arrivals==0 && num_of_blocked_arrivals==0) || (num_of_fresh_arrivals==0 && num_of_blocked_arrivals>=2 && Bupd(t)>0) || (num_of_fresh_arrivals==1 && num_of_blocked_arrivals==0)
        Bupd(t+1)=Bupd(t);
    elseif (num_of_fresh_arrivals==1 && num_of_blocked_arrivals>=1 && Bupd(t)>0) || (num_of_fresh_arrivals>=2)
        Bupd(t+1)=Bupd(t)+num_of_fresh_arrivals;
    end
    
end

plot(Bupd); grid on; xlabel('time slots'); ylabel('number of blocked terminals');
figure
plot(throupt); grid on; xlabel('time slots'); ylabel('channel throughput');