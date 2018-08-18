%Advanced Signal Processing Techniques
%2nd Question
%2nd Subquestion

%Calculation of the Cumulants of a signal x using the indirect method

function cumulants = Cumulants(x)
K = 32;
M = 64;
data = cell(1,32);
mean_segment = zeros(1,32);
for i=1:K
    data{i} = x((M*(i-1)+1) : (i*M));
    mean_segment(i) = mean(data{i});
    data{i} = data{i} - mean_segment(i);
end
cumulants = zeros(2*20+1,2*20+1);
for m = -20:20
    for n =  -20:20
        s1 = max([0 -m -n]);
        s2 = min([M-1 M-1-m M-1-n]);
        r = cell(1,32);
        for i = 1:32
            r{i} = zeros(2*20+1,2*20+1);
            for l = s1:s2
                r{i}(m+20+1,n+20+1) = r{i}(m+20+1,n+20+1) + data{i}(l+1)*data{i}(l+m+1)*data{i}(l+n+1);
            end
            r{i}(m+20+1,n+20+1) = 1/M*r{i}(m+20+1,n+20+1);
            cumulants(m+20+1,n+20+1) = cumulants(m+20+1,n+20+1) + r{i}(m+20+1,n+20+1);
        end
         cumulants(m+20+1,n+20+1) = 1/K * cumulants(m+20+1,n+20+1);
     end
end
% figure;
% surf(-20:20,-20:20,cumulants);
% legend('Cumulants');
end