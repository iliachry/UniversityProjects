Nt=3;

Nr=1;


prompt= 'Average Eb/No = ';
SNRdB = input(prompt);


prompt= 'Maximum errors to stop = ';
maxerrors = input(prompt);


prompt= 'Number of channel uses in which the channel does not change = ';
channelchange = input(prompt);

prompt= 'Seed = ';
initial = input(prompt);

Ehij2=1;
No=1;



transmitbits=zeros(1,3*Nt);
receivedbits=zeros(1,3*Nt);
testbits=zeros(1,3*Nt);

s=zeros(Nt,1);   % transmitted symbol vector
metric= zeros(1,2^(3*Nt));

x=(1/sqrt(Nt)).*[1 ; exp(-(pi/4)*(1i));  exp((3*pi/4)*(1i));  -1 ; exp((pi/4)*(1i)); exp(-(pi/2)*(1i)); exp((pi/2)*(1i)); exp(-(3*pi/4)*(1i))]; %  8-PSK Constellation with Gray Bit-Mapping so that x(1)=000 , x(2) = 100 , x(3) = 010 , x(4) = 110 , x(5) = 001 , x(6) = 101 , x(7) = 011 , x(8)=111 ... x( kdecimal + 1) = kbinary


    
rdB= SNRdB + 10*log10(3*Nt/4); % SNR/receive antenna
    
    
r=10.^(rdB/10);
    
errors=0;
    
channeluses=0;
    
myStream = RandStream('mt19937ar','seed',initial);
RandStream.setGlobalStream(myStream);
    
 
    
while errors<maxerrors
        
       
       
        channeluses = channeluses + 4;
        
        
 
        bits=randi([0,1],Nt,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
        
        
        transmitbits=reshape(bits',1,3*Nt);
            
            
      
        s=x( bi2de(bits) + 1);   % Mapping and Modulation
            
   
        S=[ s(1) s(2) s(3); conj(s(2)) conj(s(3)) conj(s(1)); -s(3) s(1) -s(2); conj(s(3)) -conj(s(2)) conj(s(1))];
        
        
      
        H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % make new channel
            
        
            
        N=complex(sqrt(No/2)*randn(Nr,4),sqrt(No/2)*randn(Nr,4));
        
      
        Y=sqrt(r)*H*transpose(S) + N;
        
        
        for l=0:2^(3*Nt)-1
            
            testbits= de2bi(l,3*Nt);
            testsymbols= x(bi2de(reshape(testbits,3,Nt)')+1);
            Testsymbols= [ testsymbols(1) testsymbols(2) testsymbols(3); conj(testsymbols(2)) conj(testsymbols(3)) conj(testsymbols(1)); -testsymbols(3) testsymbols(1) -testsymbols(2); conj(testsymbols(3)) -conj(testsymbols(2)) conj(testsymbols(1))];
            metric(l+1) = (norm(Y-sqrt(r)*H*transpose(Testsymbols), 'fro')).^2;
            
        end
        
           
        
        clear M;
        clear ind;
        
        [M,ind] = min(metric);
        
        receivedbits= de2bi(ind-1,3*Nt);
        
        
       
        
        
        Bits_simulated= 3*Nt*channeluses/4
        
        
        errors = errors + nnz(transmitbits-receivedbits)
        
        
        Current_BER=errors/Bits_simulated
        
        
       
        
end
    
X=['Eb/No = ',num2str(SNRdB) ];
disp(X) 


BER=Current_BER;

X=['BER = ',num2str(BER) ];
disp(X) 
    
    
    



 
        
        
        
        
        
        
        
                    
                
        
        
            
    




