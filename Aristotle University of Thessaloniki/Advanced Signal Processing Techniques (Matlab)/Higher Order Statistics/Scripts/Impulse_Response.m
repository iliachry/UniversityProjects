%Advanced Signal Processing Techniques
%2nd Question
%3rd Subquestion

%Estimation of the impulse response using the third order cumulants 
%of the output signal 

function [h, h1, h2] = Impulse_Response(cumulants)

h=zeros(1,6);
for i=1:6
    h(i)=cumulants(26,i+20)/cumulants(26,21);
end

h1=zeros(1,4);
for i=1:4
    h1(i)=cumulants(24,i+20)/cumulants(24,21);
end

h2=zeros(1,8);
for i=1:8
    h2(i)=cumulants(28,20+i)/cumulants(28,21);
end

end

