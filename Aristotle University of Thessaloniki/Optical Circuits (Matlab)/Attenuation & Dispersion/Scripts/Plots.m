clear all
close all
Num=8*1024;
T0=20*10^-12;
%%plot Power in Time
i=linspace(-5*T0,5*T0,Num);
m1=exp(-i.^2/(2*T0^2)).^2;
m2=exp(-i.^6/(2*T0^6)).^2;
m3=sech(i/T0).^2;
stem(i,m3)
hold on
stem(i,m2)
stem(i,m1)
legend('Sech','Super-Gaussian','Gaussian')
%%plot power in frequency
i=linspace(-((Num+1)/2)*T0,((Num+1)/2)*T0,Num+1);
y1=exp(-i.^2/(2*T0^2));
y2=exp(-i.^6/(2*T0^6));
y3=sech(i/T0);
u1=circshift(y1,[0,-(Num/2)]);
u2=circshift(y2,[0,-(Num/2)]);
u3=circshift(y3,[0,-(Num/2)]);
figure
f1=fftshift(fft(u1));
f2=fftshift(fft(u2));
f3=fftshift(fft(u3));
f1=(abs(f1.^2));
f2=(abs(f2).^2);
f3=(abs(f3).^2);
j=linspace(-1/(2*T0),1/(2*T0),Num+1);
stem(j,abs((f3)))
hold on
stem(j,abs(f2))
stem(j,abs(f1))
legend('Sech','Super-Gaussian','Gaussian')
%%Dt*Df for Gaussian
k1=m1((Num+2)/2);
k2=f1((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);
T2=1;
for i=(Num+2)/2:length(m1)
    if m1(i)<k1/2 &&Dt==0
       Dt=(2*(i-Num/2)-1)*T1;
    end
     if f1(i)<k2/2 &&Df==0
       Df=(1/Num)*(2*(i-Num/2)-1);
     end
end
fprintf('Gaussian: Dt*Dw = %2.4f\n',Dt*Df);
%%Dt*Df for Super-Gaussian
k1=m2((Num+2)/2);
k2=f2((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);
T2=1;
for i=(Num+2)/2:length(m1)
    if m2(i)<k1/2 &&Dt==0
       Dt=(2*(i-Num/2)-1)*T1;
    end
     if f2(i)<k2/2 &&Df==0
       Df=(1/Num)*(2*(i-Num/2)-1);
     end
end
fprintf('Super-Gaussian: Dt*Dw = %2.4f\n',Dt*Df);
%%Dt*Df for Sech
k1=m3((Num+2)/2);
k2=f3((Num+2)/2);
Dt=0;
Df=0;
T1=10/(Num);
T2=1;
for i=(Num+2)/2:length(m1)
    if m3(i)<k1/2 &&Dt==0
       Dt=(2*(i-Num/2)-1)*T1;
    end
     if f3(i)<k2/2 &&Df==0
       Df=(1/Num)*(2*(i-Num/2)-1);
     end
end
fprintf('Hyperbolic Secant: Dt*Dw = %2.4f\n',Dt*Df);
