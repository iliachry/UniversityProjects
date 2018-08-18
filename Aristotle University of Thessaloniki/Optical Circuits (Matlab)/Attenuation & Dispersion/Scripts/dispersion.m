function [ ] = dispersion(  )
%Dispersion plots and creates the dispersion parameters Dm,Dt,Dw
    c=3e8;
    N=1201;
    h=(1.7-1.1)/(N-1);
    lamda=1.1:h:1.7;%um
    n=n_ref(lamda,N);
    
%   Material dispersion
    Dm=-lamda(2:N-1).*(diff(diff(n)/h)/h)/c;%because of 2 differentiations lamda must be shortened
    Dm=(Dm)*1e12;% to change the unit to [ps/km-nm]
    
%   Waveguide dispersion
    a=4.5;%um
    delta=0.2e-2; %refractive indeces difference 
    V=2*pi*a*sqrt(2*delta)*n./lamda;
%   Supposing weak guidance (same as program LP01 exercise 2.2)
    b_start=0.99;
    b=zeros(1,N);
    for i=1:length(V)
        if i~=1 
            b_start=b(i-1); 
        end    
        b(i)=fsolve(@(b) sqrt(1-b)*besselj(1,V(i)*sqrt(1-b))/(besselj(0,V(i)*sqrt(1-b)))...
            -sqrt(b)*besselk(1,V(i)*sqrt(b))/besselk(0,V(i)*sqrt(b)),...
            b_start,optimoptions('fsolve','Display','off'));
    end
    b=real(b);
    dV=diff(V);%differential of V
    derV=diff(V.*b)./dV;%first derivative of V*b
    der2V=diff(derV)./dV(1:end-1);%second derivative of V*b
    Dw=-(((delta*n(2:N-1)/c).*(V(2:N-1))).*der2V)./lamda(2:N-1);
    Dw=(Dw)*1e12;%to change the unit to [ps/km-nm]
    
%   Total Dispersion
    Dt_1=Dm+Dw;
    figure; plot(lamda(2:N-1),Dt_1);
    ylabel('Dt[ps/(km-nm)]'); xlabel('wavelength [um]');
    
%   Total Dispersion direct calculation
    beta=(2*pi*n.*sqrt(2*b*delta+(1-delta)^2)./lamda);%tranform b to beta
    dbdl=diff(beta)/h;
    dbdw=-dbdl.*lamda(2:end).^2/(2*pi*c);
    Dt_2=diff(dbdw)/h*1e12;
    hold on; plot(lamda(2:N-1),Dt_2,'r');
    ylabel('Dt[ps/(km-nm)]'); xlabel('wavelength [um]');
    
%   Third order dispersion
    dD2dl=diff(Dt_2)/h*1e-3;%to change the unit to [ps/km-nm^2]
    dD1dl=diff(Dt_1)/h*1e-3;%to change the unit to [ps/km-nm^2]
%   curve fitting to be able to plot properly the curve
    fittedmodel1 = fit(lamda(2:end-2)', dD1dl', 'poly3');
    fittedmodel2 = fit(lamda(2:end-2)', dD2dl', 'poly3');
    figure; plot(fittedmodel1,'r');
    hold on; plot(fittedmodel2,'b');
    ylabel('S[ps/(km-nm^2)]'); xlabel('wavelength [um]');

end


