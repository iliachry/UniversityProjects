% Exercise 3
clear all;
close all;

m = 128;
n = 256; 

index_S = 0;
OMP_SR = zeros(length(3:3:63), 1);
SP_SR = zeros(length(3:3:63), 1);
IHT_SR = zeros(length(3:3:63), 1);

for S = 3:3:63
    index_S = index_S + 1;

    for j = 1:500
        
        A = randn(m, n);
        
        A(:,1:n) = A(:,1:n)./norm(A(:,1:n));     

        x_support_set = randsample(n,S);
        x = normrnd(0,1,n,1);
        for i = 1:n
            if ismember(i, x_support_set) == 0
                x(i) = 0;
            end
        end

        y = A*x;
        
%         xOMP = OMP(S, A, y, n);
         xSP = SP2(S, A, y, n);
        %xIHT = IHT(S, A, y, n);
        
%         if norm(xOMP - x)/norm(x) < 10^(-6)
%             OMP_SR(index_S) = OMP_SR(index_S) + 1;
%         end
%         
        if norm(xSP - x)/norm(x) < 10^(-6)
            SP_SR(index_S) = SP_SR(index_S) + 1;
        end
        
%           if immse(xOMP,x) < 10^(-6)
%             OMP_SR(index_S) = OMP_SR(index_S) + 1;
%         end
%         
%         if immse(xSP,x) < 10^(-6)
%             SP_SR(index_S) = SP_SR(index_S) + 1;
%         end

% plot(xIHT);
% hold on
% plot(x);

%         if norm(xIHT - x)/norm(x) < 10^(-6)
%             IHT_SR(index_S) = IHT_SR(index_S) + 1;
%         end
%         if immse(xIHT,x) < 10^(-6)
%             IHT_SR(index_S) = IHT_SR(index_S) + 1;
%         end
    end
end

% OMP_SR = OMP_SR / 5;
 SP_SR = SP_SR / 5;
%IHT_SR = IHT_SR / 5;

% plot(3:3:63, OMP_SR)
% hold on;
 plot(3:3:63, SP_SR);
%plot(3:3:63, IHT_SR);
legend('OMP', 'SP', 'IHT')
xlim([3 63])
xlabel('S')
ylabel('Success Rate %')
title('Success Rate vs S')