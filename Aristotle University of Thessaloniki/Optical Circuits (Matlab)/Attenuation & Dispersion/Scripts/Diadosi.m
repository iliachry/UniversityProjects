T0=20*10^(-12);
b2=-21*10^27;
Num=1025;
Ts=(10/Num)*T0;
z=linspace(0,(T0^2)/(abs(b2)),10);
i=linspace(-5*T0,5*T0,Num);
m1=exp(-i.^2/(2*T0^2)).^2;
m2=exp(-i.^6/(2*T0^6)).^2;
m3=sech(i/T0).^2;
u1=circshift(m1,[0,-((Num+1)/2-1)]);
u2=circshift(m2,[0,-((Num+1)/2-1)]);
u3=circshift(m3,[0,-((Num+1)/2-1)]);
u1=fftshift(abs(fft(u1)));
k(1:length(z),1:length(u1))=0;
for i=1:length(z)
    for j=(length(u1)+1)/2:length(u1)
        k(i,j)=u1(j)*exp((1i)*(b2/2)*((pi*j/512)/Ts)^2*z(i));
        k(i,1026-j)=k(i,j);
    end
    k(i,:)=ifft(((k(i,:))));
end
i=linspace(-5*T0,5*T0,Num);
for j=1:10
    figure;
    plot(i,abs(fftshift((k(j,:)))))
end