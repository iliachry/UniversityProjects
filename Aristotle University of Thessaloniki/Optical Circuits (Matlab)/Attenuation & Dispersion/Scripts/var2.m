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

u1 = fftshift(fft(m1));

stigm = zeros(length(z),Num);
Number = (Num+1)/2;
yax=zeros(length(z),Num);
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = u1(Number+k)*exp(1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = u1(Number+k)*exp(-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    
    %t^2
    integral1 = trapz(i,(i.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    
    %t 
    integral1 = trapz(i,i.*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    
    %sigma
    varian(j) = sqrt(t1 - t2^2);
    
end
plot(z,varian/varian(1));


u2 = fftshift(fft(m2));

stigm = zeros(length(z),Num);
Number = (Num+1)/2;

for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = u2(Number+k)*exp(1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = u2(Number+k)*exp(-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    
    %t^2
    integral1 = trapz(i,(i.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    
    %t 
    integral1 = trapz(i,i.*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    
    %sigma
    varian2(j) = sqrt(t1 - t2^2);
    
end
hold on;
plot(z,varian2/varian2(1));

u3 = fftshift(fft(m3));

stigm = zeros(length(z),Num);
Number = (Num+1)/2;
for j=1:length(z)
    for k = 0:Number-1
        stigm(j,Number + k) = u3(Number+k)*exp(+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
        stigm(j,Number - k) = u3(Number+k)*exp(-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
    end
    proti(j,:) = ifft(ifftshift(stigm(j,:)));
    
    %t^2
    integral1 = trapz(i,(i.^2).*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t1 = integral1/integral2;
    
    %t 
    integral1 = trapz(i,i.*abs(proti(j,:)).^2);
    integral2 = trapz(i,abs(proti(j,:)).^2);
    t2 = integral1/integral2;
    
    %sigma
    varian3(j) = sqrt(t1 - t2^2);
    
end
hold on;
plot(z,varian3/varian3(1));
grid on;
legend('Gaussian','Super-Gaussian','Hyperbolic Secant');