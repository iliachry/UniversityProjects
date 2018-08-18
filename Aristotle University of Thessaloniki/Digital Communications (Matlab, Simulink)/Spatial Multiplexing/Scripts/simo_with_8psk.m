%function [SNRdB,BER]=simo_with_8psk(Nr,SNRdB,maxerrors,p,checkconstellation,initial)

Nt=1;

prompt= 'Number of receive antennas = ';
Nr = input(prompt);


prompt= 'Average Eb/No = ';
SNRdB = input(prompt);

prompt= 'Maximum errors to stop = ';
maxerrors = input(prompt);

A=['Correlation between the ',num2str(Nr), ' fading channels = '];

prompt= A;
p = input(prompt);

prompt= 'View constellation diagrams: ';
checkconstellation = input(prompt);

prompt= 'Number of channel uses in which the channel does not change = ';
channelchange = input(prompt);

prompt= 'Seed = ';
initial = input(prompt);

Ehij2=1;
No=1;

R=p*ones(Nr,Nr)-p*eye(Nr)+eye(Nr); % correlation matrix

C=sqrt(Ehij2/2)*ones(1,Nr); % standard variation of hij

mu=zeros(Nr,1); % mean value of hij

S=diag(C)*R*diag(C);  % Covariance matrix

x=(1/sqrt(Nt)).*[1 ; exp(-(pi/4)*(1i));  exp((3*pi/4)*(1i));  -1 ; exp((pi/4)*(1i)); exp(-(pi/2)*(1i)); exp((pi/2)*(1i)); exp(-(3*pi/4)*(1i))]; %  8-PSK Constellation with Gray Bit-Mapping so that x(1)=000 , x(2) = 100 , x(3) = 010 , x(4) = 110 , x(5) = 001 , x(6) = 101 , x(7) = 011 , x(8)=111 ... x( kdecimal + 1) = kbinary



tf = strcmp(checkconstellation,'Yes');
if tf == 1
   con=cell(1,Nr);

   for i=1:Nr
    
   
       X = ['Constellation Diagram for the receive antenna ',num2str(i)];
      con{i} = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
      'XLimits',[-30 30],'YLimits',[-30 30]);
   end

   X = 'Constellation Diagram after combiner ';
   cons = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
   'XLimits',[-60 60],'YLimits',[-60 60]);
end







transmitbits=zeros(1,3*Nt);
receivedbits=zeros(1,3*Nt);


s=zeros(Nt,1);   % transmitted symbol vector
metric= zeros(1,8);



rdB= SNRdB + 10*log10(3*Nt); % SNR/receive antenna
    
    
    
r=10.^(rdB/10);
    
errors=0;
    
channeluses=0;
    
myStream = RandStream('mt19937ar','seed',initial);
RandStream.setGlobalStream(myStream);
    
absfading=[];
anglefading=[];
    
while errors<maxerrors
        
       
       
        channeluses = channeluses + 1;
        
        
 
        bits=randi([0,1],Nt,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
        
        
        transmitbits=bits;
            
            
      
        s=x( bi2de(bits) + 1);   % Mapping and Modulation
            
   
        
        
      
        if channelchange == 1
            
            H=complex(mvnrnd(mu,S),mvnrnd(mu,S)); % the channel changes at every use
            
            
        elseif mod(channeluses,channelchange) == 1
            
            H=complex(mvnrnd(mu,S),mvnrnd(mu,S)); % make new channel
            
            
        end
        
        
   
        n=complex(sqrt(No/2)*randn(Nr,1),sqrt(No/2)*randn(Nr,1));
        
        
        H=reshape(H,Nr,Nt);
        
        
    
        y=sqrt(r)*H*s + n;
        
        
        ycombined= (H')*y;
        
        
        if tf == 1
            
        
           for l=1:Nr
            
               step(con{l},y(l))
            
           end
        
        
           step(cons,ycombined)
        end




       
        h=sum(abs(H).^2);
        
        if length(absfading) < 8000
            
            absfading=[absfading [h; abs(H)]];
       
            anglefading=[anglefading  [angle(h); angle(H)]];
            
        end
        
        
        metric=real(ycombined*conj(h*x));
        
        
        clear M;
        clear I;
        
        [M,I] = max(metric);
        
        receivedbits= de2bi(I-1,3*Nt);
        
        
       
        
        
       
        Bits_simulated= 3*Nt*channeluses
        
        
        errors = errors + nnz(transmitbits-receivedbits)
        
        
        Current_BER=errors/Bits_simulated
        
        
       
        
end


    

X=['Eb/No = ',num2str(SNRdB) ];
disp(X) 


BER=Current_BER;

X=['BER = ',num2str(BER) ];
disp(X) 



if channeluses<8000
    a=channeluses;
else
    a=8000;
end


C=['Absolute value of the fading coefficients for the first ',num2str(a),' channel uses'];
figure

for i=1:Nr+1
    
    
  
    plot(absfading(i,:))
    
    title(C)
    xlabel('Channel uses')
    ylabel('Absolute value of the fading coefficients')
    
    
    grid on
    
    
    axis([0,a,-Inf,Inf])
    
    
    hold on
    
    
end




Y=cell(1,Nr+1);
Y{1}='After Combiner';
for i=2:Nr+1
    
    Y{i}=[ 'Channel ',num2str(i-1)];
end


legend(Y,'Location','northoutside','Orientation','Horizontal' )
   
    
C=['Phase of the fading coefficients for the first ',num2str(a),' channel uses'];    
figure
for i=1:Nr+1
    
    
  
    plot(180*anglefading(i,:)/pi)
    
    title(C)
    xlabel('Channel uses')
    ylabel('Phase of the fading coefficients ( degrees)')
    
    
    grid on
    
    
    axis([0,a,-Inf,Inf])
    
    
    hold on
    
    
end
 
        
legend(Y,'Location','northoutside','Orientation','horizontal')
 
        
        
        
        
        
        
        
                    
                
        
        
            
    




