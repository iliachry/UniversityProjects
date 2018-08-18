function [ ] = time_dispersion( N,tw )
%time_dispersion creates 3 kind of pulses and plots its power     
%   t[psec]
    To=25;%psec
    D=17;%ps/nm/km
    lamda=1550;%nm
    c=3e8;
    b2=-(D*lamda^2/(2*pi*c));
    h=2*tw*To/N;
    fs=1/h;
    t=(-tw*To:h:tw*To-h);
    f=(-0.5*fs:fs/N:0.5*fs-fs/N);
%   Raised-cosine
    A1=0.5+0.5*cos(pi*t/(2*To));
    q=abs(t)>=2*To;
    A1(q)=0;
%   Gaussian
    A2=exp(-t.^2/(To^2));
%   Hyperbolic secant
    A3=sech(t/To);
%   Plot the power
    pow_A1=abs(A1).^2;
    pow_A2=abs(A2).^2;
    pow_A3=abs(A3).^2;
    q=abs(t)<=5*To;
    figure;subplot(3,1,1);
    plot(t(q),pow_A1(q));title('Power amplitude');xlabel('t[psec]');ylabel('Raised Cos');
    subplot(3,1,2);plot(t(q),pow_A2(q));xlabel('t[psec]');ylabel('Gaussian');
    subplot(3,1,3);plot(t(q),pow_A3(q));xlabel('t[psec]');ylabel('Hyp Sec');
%   Power spectrum
    A1_ft=h*fftshift(fft(A1));
    A2_ft=h*fftshift(fft(A2));
    A3_ft=h*fftshift(fft(A3));
    pow_A1_ft=abs(A1_ft).^2;
    pow_A2_ft=abs(A2_ft).^2;
    pow_A3_ft=abs(A3_ft).^2;
%   Plot the power spectrum
    q=abs(f)<=0.5/To+fs/N;
    figure;subplot(3,1,1);
    plot(f(q),pow_A1_ft(q));title('Power spectrum');xlabel('f[THz]');ylabel('Raised Cos');
    subplot(3,1,2);plot(f(q),pow_A2_ft(q));xlabel('f[THz]');ylabel('Gaussian');
    subplot(3,1,3);plot(f(q),pow_A3_ft(q));xlabel('f[THz]');ylabel('Hyp Sec');
%   Calculate the FWHM
    dt1=FWHM(pow_A1,h)%psec
    dt2=FWHM(pow_A2,h)%psec
    dt3=FWHM(pow_A3,h)%psec
    dw1=FWHM(pow_A1_ft,fs/N)*2*pi
    dw2=FWHM(pow_A2_ft,fs/N)*2*pi
    dw3=FWHM(pow_A3_ft,fs/N)*2*pi
    diff1=dt1*dw1
    diff2=dt2*dw2
    diff3=dt3*dw3
	[Bf1,z1norm]=time_dsp(A1_ft, f, dt1, b2, t);
	[Bf2,z2norm]=time_dsp(A2_ft, f, dt2, b2, t);
    [Bf3,z3norm]=time_dsp(A3_ft, f, dt3, b2, t);
    figure;plot(z1norm,Bf1,'r');hold on;
    plot(z2norm,Bf2,'g');hold on; plot(z3norm,Bf3,'b');
    xlabel('z/L');ylabel('Bf');
    
end

