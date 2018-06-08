%Telecommunication Networks
%Simulation of Telecomunnications loss systems
%Chrysovergis Ilias - 8009
%iliachry@ece.auth.gr


%2nd question

%Theoretical

lambda = 1/20;
m = 1/200;
r = lambda/m;
min_prob = 0.001;
max_prob = 0.2;
N = 5:1:30;
prob = zeros(1,length(N));
for i = 1:length(N)
    sum = 0;
    for k = 0:N(i)
        sum = sum + (r^k)/factorial(k);
    end
    prob(i) = r^(N(i))/factorial(N(i))/sum;
end
j = 0;
for i = 1:length(N)
    if (prob(i) <= max_prob && prob(i)>= min_prob)
        j = j+1
        N2(j) = N(i); 
        PB_theor(j) = prob(i);
    end
end
stem(N2(1:j),PB_theor(1:j))

%Simulation

maximum_calls = 100000;
min_N = N2(1);
max_N = N2(10);
PB_sim1 = zeros(1,10);
for N = min_N:max_N
    line = zeros(1,N);
    customers = 1;
    line(1) = exprnd(200);
    time = 0;
    while customers < maximum_calls
        customers = customers + 1;
        time = time + exprnd(20);
        blocked = 1;
        for j = 1:N
            if line(j) < time
                line(j) = time + exprnd(200);
                blocked = 0;
                break 
            end
        end
        if blocked == 1
            PB_sim1(N-min_N+1) = PB_sim1(N-min_N+1) + 1;
        end
    end   
end
PB_sim1 = PB_sim1/maximum_calls;
hold on
stem(N2(1:10),PB_sim1);
title('Blocking Probability versus N on Erlang B system')
xlabel('N')
ylabel('Pb')
legend('Theoretical','Simulation')
grid on

%3rd question 

PB_sim2 = zeros(1,10);
for N = min_N:max_N
    line = zeros(1,N);
    customers = 1;
    line(1) = normrnd(200,1);
    while line(1) <= 0
            line(1) = normrnd(200,1);
    end
    time = 0;
    while customers < maximum_calls
        customers = customers + 1;
        time = time + exprnd(20);
        blocked = 1;
        for j = 1:N
            if line(j) < time
                x = normrnd(200,1);
                while line(1) <= 0
                    x = normrnd(200,1);
                end
                line(j) = time + x;
                blocked = 0;
                break 
            end
        end
        if blocked == 1
            PB_sim2(N-min_N+1) = PB_sim2(N-min_N+1) + 1;
        end
    end   
end
PB_sim2 = PB_sim2/maximum_calls;
figure;
stem(N2(1:10),PB_sim1);
hold on
stem(N2(1:10),PB_sim2);
title('Blocking Probability versus N for Different Call Distributions')
xlabel('N')
ylabel('Pb')
legend('Exponential Distribution','Normal Distribution')
grid on
