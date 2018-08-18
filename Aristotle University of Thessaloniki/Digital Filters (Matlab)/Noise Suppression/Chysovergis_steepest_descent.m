%Steepest descent demo
%
%author : Nikos Sismanis
%date   : March 2013
%
%edit   : Ilias Chrysovergis
%date   : March 2016

clear all
close all

n = 1000; % number of time steps
N = 1:n;

%% signals 
 
x = (cos(pi*N).*sin((pi/25)*N + pi/3))';  % information signal 
v = sqrt(0.19)*randn(n,1); % Gaussian white noise
v = v - mean(v); % Gaussian white noise (E[v] = 0 , E[v^2] = 0.19)
d = x + v; % information signal with additive gaussian white noise 

%AR process 
u = zeros(n,1);
u(1) = v(1);
for i=2:n
  u(i) = -0.78* u(i-1) + v(i);
end

figure(1)
plot([d x u])
legend({'d(n)', 'x(n)', 'u(n)'})

%% fir filter

R = [0.4852 -0.3784; -0.3784 0.4852]; % autocorrelation E[u u']
P = [0.19; 0];  % cross correlation E[u d]
wo = R \ P;

T = [u [0; u(1:n-1)]]; 

yo = T*wo;

figure(2)
plot([d yo])
legend({'d(n)', 'y(n)'})

%% clean signal
e = d - yo;
figure(3)
plot([e yo]);
legend({'e(n)', 'y(n)'});

%% Steepest descent
w = [-1; -1]; 
parametres = [-0.5 0 1 1.5  2/max(eig(R)) 2.5]'; % diffent values for mu
mu = parametres(1);

wt = zeros([2,n]); wt(:,1) = w;
y = zeros(n, 1);

s = [0; u];
for i=2:n
  w = w + mu*(P-R*w); % Adaptation steps
  wt(:,i) = w;
  y(i) = s(i:-1:i-1)' * w; % filter
end

figure(4)
plot([d y])
legend({'d(n)', 'y(n)'})

%% parameter error
figure(5)
we = (wt - wo*ones(1,n)).^2;
e = sqrt(sum(we));

semilogy(e);
xlabel('time step n');
ylabel('Parameter error');
title({'Parameter error'});


%% contour curves and trajectories
L = 50;
ww = linspace(-2.5,2.5,L);

J = zeros([L,L]);
sigma2d = 0.1;

% Construct the error surface
for i=1:L
  for k=1:L
    wp = [ww(i); ww(k)];
    J(k,i) = sigma2d - 2*P'*wp + wp'*R*wp;
  end
end

min_J = min(J(:));
max_J = max(J(:));

levels = linspace(min_J,max_J,12);

figure(6)
contour(ww, ww, J, levels); axis square
hold on

plot(wt(1,:), wt(2,:), 'xr--');
hold off
colorbar
xlabel('w(1)');
ylabel('w(2)');
title({'Error Surface and Adaptation process'});