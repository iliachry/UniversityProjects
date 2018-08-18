%Advanced Signal Processing Techniques
%2nd Question
%4th Subquestion

%Estimation of the input signal by using the impulse responses
%of the signal and calculation of the estimation error and the MSE

function [x1, x2, x3, e1, e2, e3] = Signal_Generation(x, v, h, h1, h2)

%Input Signal Estimation
x1 = conv(v, h, 'same');
x2 = conv(v, h1, 'same');
x3 = conv(v, h2, 'same');
x1 = circshift(x1, 3, 2);
x2 = circshift(x2, 2, 2);
x3 = circshift(x3, 4, 2);

%Estimation Error Calculation
e1 = immse(x, x1);
e2 = immse(x, x2);
e3 = immse(x, x3);

% t=1:1:2048;
% %x1 vs x plot
% figure(1)
% plot(t,x1(t),t,x(t));
% legend('x1','x');
% title('x1 vs x');
% 
% %x-x1 plot
% figure(2)
% plot(t,x - x1);
% legend('x-x1');
% title('x-x1');
% 
% %x2 vs x plot
% figure(3)
% plot(t,x2(t),t,x(t));
% legend('x2','x');
% title('x2 vs x');
% 
% %x-x2 plot
% figure(4)
% plot(t,x - x2);
% legend('x-x2');
% title('x-x2');
% 
% %x3 vs x plot
% figure(5)
% plot(t,x3(t),t,x(t));
% legend('x3','x');
% title('x3 vs x');
% 
% %x-x3 plot
% figure(6)
% plot(t,x - x3);
% legend('x-x3');
% title('x-x3');

end