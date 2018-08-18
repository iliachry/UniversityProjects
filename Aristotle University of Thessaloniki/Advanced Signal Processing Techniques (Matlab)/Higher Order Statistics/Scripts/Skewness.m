%Advanced Signal Processing Techniques
%2nd Question
%1st Subquestion

%Calculation of the Skewness of an exponential distributed signal and 
%implementation of the output signal of a MA process 

function [skewness, x, h, v] = Skewness()

%Input of the system, created by exponential distribution with mean = 1
v = exprnd(1,1,2048);

%The MA filter coefficients
h = [1.0 0.91 0.81 -0.7 0.57 -0.10];

%Generating the x signal
x = filter(h,1,v);

%Calulating the Skewness of the input
mean_v = mean(v);
std_v = std(v);
gama_v = 0;

for i=1:2048
    gama_v = gama_v + (v(i)-mean_v)^3;
end
skewness = gama_v/(2047*std_v^3);

end





