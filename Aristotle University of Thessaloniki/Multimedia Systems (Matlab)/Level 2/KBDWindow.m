function window=KBDWindow(N,alpha)
M=N/2;    
kb=kaiser(M+1,alpha);
window=zeros(1,N);
sum1=0;
for i=1:M
    sum1=sum1+kb(i);
    window(i)=sum1;
end
window(M+1:2*M)=window(M:-1:1);
window=sqrt(window/(sum1+kb(M+1)));
end