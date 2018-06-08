function [ I, HPBW, D ] = Dolph_chebyshev( N, R, d_lamda ) 
Ro=10^(R/20);
zo=cosh(1/(N-1)*acosh(Ro));
f=1+0.636*(2/Ro*cosh(sqrt((acosh(Ro))^2-pi^2)))^2; %beam broadening factor
hp=48.4/(N*d_lamda); 
HPBW=f*hp;
D=2*Ro^2/(1+(Ro^2-1)*f/(N*d_lamda));
D=10*log10(D);
T=zeros(N);
T(1,1)=1;
T(2,2)=1;
%Chebysev Coefficients
for i=3:N
    T(i,1)=-T(i-2,1);
    for j=2:N
        T(i,j)=2*T(i-1, j-1)-T(i-2, j);
    end
    
end

if(mod(N,2)==0)
    j=1;
    for i=2:2:N
        A(j,:)=T(i,:);
        j=j+1;
    end
    j=1;
    L=zeros(N/2);
    for i=2:2:N
      L(:,j)=A(:,i);
      j=j+1;
    end
    L=L';
    B=T(N,:)';
    j=1;
    for i=2:2:N
        G(j)=B(i)*zo^i;
        j=j+1;
    end
    G=G';
    I=L\G;
    for i=1:N/2
        I(i)=I(i)/I(N/2); %kanonikopoisi reymatos
    end
    theta=0:2*pi/1000:2*pi;
    u=pi*d_lamda*cos(theta);
    A=0;
    for i=1:(N/2)
        A=I(i)*cos((2*i-1)*u)+A; %ypologismos AF
    end
    A=A/max(A); %kanonikopoiisi AF
    polar_dB(theta, A.^2, 80, 10, 12)
end

if(mod(N,2)==1)
    j=1;
    for i=1:2:N
        A(j,:)=T(i,:);
        j=j+1;
    end
    j=1;
    L=zeros(floor(N/2)+1);
    for i=1:2:N
      L(:,j)=A(:,i);
      j=j+1;
    end
    L=L';
    B=T(N,:)';
    j=1;
    for i=1:2:N
        G(j)=B(i)*zo^i;
        j=j+1;
    end
    G=G';
    I=L\G;
    for i=1:floor(N/2)+1
        I(i)=I(i)/I(floor(N/2)+1);
    end
    A=0;
    theta=0:2*pi/1000:2*pi;
    u=pi*d_lamda*cos(theta);
    for i=1:floor(N/2)+1
        A=I(i)*cos(2*(i-1)*u)+A;
    end
    A=A/max(A);
    polar_dB(theta, A.^2, 60, 10, 12);
    
end 
%I=I';
end

