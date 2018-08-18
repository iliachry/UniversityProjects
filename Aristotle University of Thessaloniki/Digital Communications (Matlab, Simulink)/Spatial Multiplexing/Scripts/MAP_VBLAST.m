prompt= 'Number of transmit antennas = ';
Nt = input(prompt);

prompt= 'Number of receive antennas = ';
Nr = input(prompt);


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





testbits=zeros(1,3*Nt);

s=zeros(Nt,1);   % transmitted symbol vector
metric= zeros(1,2^(3*Nt));

x=(1/sqrt(Nt)).*[1 ; exp(-(pi/4)*(1i));  exp((3*pi/4)*(1i));  -1 ; exp((pi/4)*(1i)); exp(-(pi/2)*(1i)); exp((pi/2)*(1i)); exp(-(3*pi/4)*(1i))]; %  8-PSK Constellation with Gray Bit-Mapping so that x(1)=000 , x(2) = 100 , x(3) = 010 , x(4) = 110 , x(5) = 001 , x(6) = 101 , x(7) = 011 , x(8)=111 ... x( kdecimal + 1) = kbinary




rdB= SNRdB + 10*log10(3*Nt); % SNR/receive antenna
    
    
    
r=10.^(rdB/10);
    
Errors_per_layer=zeros(Nt,1);
    
channeluses=0;
    
myStream = RandStream('mt19937ar','seed',initial);
RandStream.setGlobalStream(myStream);
    
 
    
while min(Errors_per_layer)<maxerrors
        
       
       
        channeluses = channeluses + 1;
        
        
 
        bits=randi([0,1],Nt,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
        
        
        transmitbits=bits;
            
            
      
        s=x( bi2de(bits) + 1);   % Mapping and Modulation
            
   
        
        
      
        if channelchange == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % the channel changes at every use
            
        elseif mod(channeluses,channelchange) == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % make new channel
            
        end
        
        
    
        n=complex(sqrt(No/2)*randn(Nr,1),sqrt(No/2)*randn(Nr,1));
        
      
        y=sqrt(r)*H*s + n;
        
        
        
        for l=0:2^(3*Nt)-1
            
            testbits= de2bi(l,3*Nt);
            testsymbols= x(bi2de(reshape(testbits,3,Nt)')+1);
            metric(l+1) = (norm(y-sqrt(r)*H*testsymbols, 'fro')).^2;
            
        end
        
           
        
        clear M;
        clear ind;
        
        [M,ind] = min(metric);
        
        receivedbits= de2bi(ind-1,3*Nt);
        
        
        receivedbits=reshape(receivedbits,3,Nt)';
        
       
        Bits_simulated_per_layer= 3*channeluses
        
        Total_bits_simulated= Bits_simulated_per_layer*Nt
        
        
        Errors_per_layer = Errors_per_layer + sum(abs(transmitbits-receivedbits),2)
        
        
        Current_BER_per_layer= Errors_per_layer./Bits_simulated_per_layer
        
        
        
        
end
    
    
    
    
    
X=['Eb/No = ',num2str(SNRdB) ];
disp(X) 


BER=Current_BER_per_layer;

for i=1:Nt
    
    Y =[ 'BER for Layer ',num2str(i), ' = ', num2str(BER(i))];
    disp(Y)
    
end



 
        
        
        
        
        
        
        
                    
                
        
        
            
    







