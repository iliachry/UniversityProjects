close all;
clear all;
T0 = 20*10^(-12);
beta2 = -21*10^(-27);
beta3 = 1.3*10^(-40);
Num = 8193;
Ts = 100*T0/(Num-1);
Ld2=T0^2/abs(beta2);
z = linspace(0,4*Ld2,10);
t = linspace(-50*T0,50*T0, Num);
Gaussian = exp(-t.^2/(2*T0^2));
Super_Gaussian = exp(-t.^6/(2*T0^6));
Hyper_Secant = sech(t/T0);
GF = fftshift(fft(Gaussian));

stigm = zeros(length(z),Num);
Number = (Num+1)/2;
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = GF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j));%...
           % +1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = GF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j));%...
            %-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    %t^2
    integral1 = trapz(t,(t.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    %t 
    integral1 = trapz(t,t.*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    %variance
    varian(j) = sqrt(t1 - t2^2);
end
plot(z,varian/varian(1));


SGF = fftshift(fft(Super_Gaussian));

stigm = zeros(length(z),Num);
Number = (Num+1)/2;

for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = SGF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j));%+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = SGF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j));%;-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    
    %t^2
    integral1 = trapz(t,(t.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    
    %t 
    integral1 = trapz(t,t.*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    
    %sigma
    varian2(j) = sqrt(t1 - t2^2);
    
end
hold on;
plot(z,varian2/varian2(1));

HSF = fftshift(fft(Hyper_Secant));


stigm = zeros(length(z),Num);
Number = (Num+1)/2;
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = HSF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j));%+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = HSF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j));%-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    
    %t^2
    integral1 = trapz(t,(t.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    
    %t 
    integral1 = trapz(t,t.*abs(proti(j,:)).^2);
    integral2 = trapz(t,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    
    %sigma
    varian3(j) = sqrt(t1 - t2^2);
    
end
hold on;
plot(z,varian3/varian3(1));
grid on;
legend('Gaussian','Super-Gaussian','Hyperbolic Secant');

% for j = 1:length(z)
%     trapz


























