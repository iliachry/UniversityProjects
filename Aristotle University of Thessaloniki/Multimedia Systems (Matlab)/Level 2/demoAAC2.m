function SNR = demoAAC2(fNameIn, fNameOut)
y=audioread(fNameIn);
tic
x=AACoder2(fNameIn);
pause(1);
time=toc;
formatSpec1= 'Time elapsed for coding is %5.5f seconds \n';
fprintf(formatSpec1,time)
tic
z=iAACoder2(x,fNameOut);
pause(1);
time=toc;
formatSpec1= 'Time elapsed for decoding is %5.5f seconds \n';
fprintf(formatSpec1,time)
minsize=min(size(z,1),size(y,1));
SNR1=10*log10(var(y(1:minsize,1))/var(y(1:minsize,1)-z(1:minsize,1)));
SNR2=10*log10(var(y(1:minsize,2))/var(y(1:minsize,2)-z(1:minsize,2)));
SNR=[SNR1,SNR2];
end