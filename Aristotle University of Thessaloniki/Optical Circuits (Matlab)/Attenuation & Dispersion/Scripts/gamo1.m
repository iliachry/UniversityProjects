close all;
clear all;
T0 = 20*10^(-12);
beta2 = -21*10^(-27);
beta3 = 1.3*10^(-40);
Num = 8193;
Ts = 100*T0/(Num-1);
Ld3=T0^3/abs(beta3);
z = linspace(0,4*Ld3,10);
i = linspace(-50*T0,50*T0, Num);

m1=exp(-i.^2/(2*T0^2));
m2=exp(-i.^6/(2*T0^6));
m3=sech(i/T0);

u1 = fftshift(fft(m3));

stigm = zeros(length(z),Num);

Number = (Num+1)/2;
yax=zeros(length(z),Num);
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = u1(Number+k)*exp(+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = u1(Number+k)*exp(-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    yax(j,:)=z(j)*ones(1,Num);
    proti = ifft(ifftshift(stigm(j,:)));
    %figure;
    plot3(i(length(i):-1:1)/T0,yax(j,:)/Ld3,abs(proti).^2)
    hold on
end
xlim([-5 5])
grid on