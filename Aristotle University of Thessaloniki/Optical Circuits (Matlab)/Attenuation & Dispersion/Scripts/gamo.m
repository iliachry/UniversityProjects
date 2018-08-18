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
GF = fftshift(fft(Hyper_Secant));
stigm = zeros(length(z),Num);
Number = (Num+1)/2;
y = zeros(length(z),Num);
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = GF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j)...
            +1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = GF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j)...
            -(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    y(j,:) = z(j)*ones(1,Num);
    proti = ifft(ifftshift(stigm(j,:)));
    plot3(t/T0,y(j,:)/Ld2,abs(proti).^2)
    hold on
end
xlim([-5 5])
grid on