clear all
close all

%Parameters 
beta2 = -21*10^(-27);
beta3 = 1.3*10^(-40);
T0 = 20*10^(-12);
Num=8*1024;
Ts = 100*T0/(Num-1);

%Time Domain
t1 = linspace(-5*T0,5*T0,Num);
Gaussian = exp(-t1.^2/(2*T0^2)).^2;
Super_Gaussian = exp(-t1.^6/(2*T0^6)).^2;
Hyper_Secant = sech(t1/T0).^2;
plot(t1,Gaussian)
hold on
plot(t1,Super_Gaussian)
plot(t1,Hyper_Secant)
legend('Gaussian','Super-Gaussian','Hyperbolic Secant')

%Frequency Domain
t2 = linspace(-(Num+1)/2*T0,(Num+1)/2*T0,Num+1);
Gaussian2 = exp(-t2.^2/(2*T0^2));
Super_Gaussian2 = exp(-t2.^6/(2*T0^6));
Hyper_Secant2 = sech(t2/T0);
GF = fftshift(fft(Gaussian2));
SGF = fftshift(fft(Super_Gaussian2));
HSF = fftshift(fft(Hyper_Secant2));
GF = (abs(GF.^2));
SGF = (abs(SGF).^2);
HSF = (abs(HSF).^2);
j = linspace(-1/(2*T0),1/(2*T0),Num+1);
figure;
plot(j,GF)
hold on
plot(j,SGF)
plot(j,HSF)
legend('Gaussian','Super-Gaussian','Hyperbolic Secant')

%%Dt*Df for Gaussian
j1=Gaussian((Num+2)/2);
j2=GF((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);

flag1 = 1;
flag2 = 1;

for t1=(Num+2)/2:length(t1)
    if Gaussian(t1)<j1/2 && flag1 == 1
       flag1 = 0;
       Dt=(2*(t1-Num/2)-1)*T1;
    end
     if GF(t1)<j2/2 && flag2 == 1;
       flag2 = 0;
       Df=(1/Num)*(2*(t1-Num/2)-1);
     end
end
fprintf('Gaussian: Dt*Dw = %2.4f\n',Dt*Df);

%%Dt*Df for Super-Gaussian
j1=Super_Gaussian((Num+2)/2);
j2=SGF((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);

flag1 = 1;
flag2 = 1;

for t1=(Num+2)/2:length(t1)
    if Super_Gaussian(t1)<j1/2 && flag1 == 1
       flag1 = 0;
       Dt=(2*(t1-Num/2)-1)*T1;
    end
     if SGF(t1)<j2/2 && flag2 == 1;
       flag2 = 0;
       Df=(1/Num)*(2*(t1-Num/2)-1);
     end
end
fprintf('Super-Gaussian: Dt*Dw = %2.4f\n',Dt*Df);

%%Dt*Df for Sech
j1=Hyper_Secant((Num+2)/2);
j2=HSF((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);
flag1 = 1;
flag2 = 1;

for t1=(Num+2)/2:length(t1)
    if Hyper_Secant(t1)<j1/2 && flag1 == 1
       flag1 = 0;
       Dt=(2*(t1-Num/2)-1)*T1;
    end
    if HSF(t1)<j2/2 && flag2 == 1;
       flag2 = 0;
       Df=(1/Num)*(2*(t1-Num/2)-1);
    end
end
fprintf('Hyperbolic Secant: Dt*Dw = %2.4f\n',Dt*Df);

% %%question2
% Num = 8193;
% 
% Ts = 100*T0/(Num-1);
% Ld2=T0^2/abs(beta2);
% z = linspace(0,4*Ld2,10);
% t1 = linspace(-50*T0,50*T0, Num);
% stigm = zeros(length(z),Num);
% 
% Gaussian=exp(-t1.^2/(2*T0^2)).^2;
% Super_Gaussian=exp(-t1.^6/(2*T0^6)).^2;
% Hyper_Secant=sech(t1/T0).^2;
% 
% GF = fftshift(fft(Gaussian));
% SGF=fftshift(fft(Super_Gaussian));
% HSF=fftshift(fft(Hyper_Secant));
% 
% figure;
% Number = (Num+1)/2;
% yax=zeros(length(z),Num);
% for j=1:length(z)
%     for k = 0:Number-1
%         stigm(j,Number + k) = GF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j)+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
%         stigm(j,Number - k) = GF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j)-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
%     end
%     yax(j,:)=z(j)*ones(1,Num);
%     proti = ifft(ifftshift(stigm(j,:)));
%     %figure;
%     plot3(t1/T0,yax(j,:)/Ld2,abs(proti).^2)
%     hold on
% end
% xlim([-5 5])
% grid on
% 
% figure;
% Number = (Num+1)/2;
% yax=zeros(length(z),Num);
% for j=1:length(z)
%     for k = 0:Number-1
%         stigm(j,Number + k) = SGF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j)+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
%         stigm(j,Number - k) = SGF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j)-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
%     end
%     yax(j,:)=z(j)*ones(1,Num);
%     proti = ifft(ifftshift(stigm(j,:)));
%     %figure;
%     plot3(t1/T0,yax(j,:)/Ld2,abs(proti).^2)
%     hold on
% end
% xlim([-5 5])
% grid on
% 
% figure;
% Number = (Num+1)/2;
% yax=zeros(length(z),Num);
% for j=1:length(z)
%     for k = 0:Number-1
%         stigm(j,Number + k) = HSF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j)+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
%         stigm(j,Number - k) = HSF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j)-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
%     end
%     yax(j,:)=z(j)*ones(1,Num);
%     proti = ifft(ifftshift(stigm(j,:)));
%     %figure;
%     plot3(t1/T0,yax(j,:)/Ld2,abs(proti).^2)
%     hold on
% end
% xlim([-5 5])
% grid on
% 
% %question3 
% for j=1:length(z)
%     for k = 0:Number-1
%         stigm(j,Number + k) = GF(Number+k)*exp(1i*beta2/2*(pi*k/(Number*Ts)).^2*z(j)+1/6*1i*beta3*z(j)*(pi*(k/(Number*Ts))).^3);
%         stigm(j,Number - k) = GF(Number+k)*exp((1i)*(beta2/2)*(pi*k/(Number*Ts)).^2*z(j)-(1/6)*(1i)*(beta3)*z(j)*(pi*(k/(Number*Ts))).^3);
%     end
%     proti(j,:) = ifft(ifftshift(stigm(j,:)));
%     
%     %t^2
%     integral1 = trapz(t1,(t1.^2).*abs(proti(j,:)).^2);
%     integral2 = trapz(t1,abs(proti(j,:)).^2);
%     t1 = integral1/integral2;
%     
%     %t 
%     integral1 = trapz(t1,t1.*abs(proti(j,:)).^2);
%     integral2 = trapz(t1,abs(proti(j,:)).^2);
%     t2 = integral1/integral2;
%     
%     %sigma
%     varian(j) = sqrt(t1 - t2^2);
%     
% end
% plot(z,varian/varian(1));

