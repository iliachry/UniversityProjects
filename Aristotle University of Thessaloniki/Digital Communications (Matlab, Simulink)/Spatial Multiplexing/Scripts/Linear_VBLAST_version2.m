prompt= 'Number of transmit antennas = ';
Nt = input(prompt);

prompt= 'Number of receive antennas = ';
Nr = input(prompt);


prompt= 'Average Eb/No = ';
SNRdB = input(prompt);

prompt= 'View constellation diagrams: ';
checkconstellation = input(prompt);

prompt= 'Maximum errors to stop = ';
maxerrors = input(prompt);


prompt= 'Number of channel uses in which the channel does not change = ';
channelchange = input(prompt);

prompt= 'Seed = ';
initial = input(prompt);

Ehij2=1;
No=1;


transmitbits=zeros(Nt,3);
receivedbits=zeros(Nt,3);


s=zeros(Nt,1);   % transmitted symbol vector


x=(1/sqrt(Nt)).*[1 ; exp(-(pi/4)*(1i));  exp((3*pi/4)*(1i));  -1 ; exp((pi/4)*(1i)); exp(-(pi/2)*(1i)); exp((pi/2)*(1i)); exp(-(3*pi/4)*(1i))]; %  8-PSK Constellation with Gray Bit-Mapping so that x(1)=000 , x(2) = 100 , x(3) = 010 , x(4) = 110 , x(5) = 001 , x(6) = 101 , x(7) = 011 , x(8)=111 ... x( kdecimal + 1) = kbinary


tf = strcmp(checkconstellation,'Yes');
if tf == 1
    
   con=cell(1,Nt);
   
   for i=1:Nt
    
   
       X = ['Constellation Diagram for the layer - data stream ',num2str(i)];
      con{i} = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
      'XLimits',[-60 60],'YLimits',[-60 60]);
   end

  
end


    
 rdB= SNRdB + 10*log10(3*Nt); % SNR/receive antenna
    
    
    
 p=10.^(rdB/10);
    
 Errors_per_layer=zeros(Nt,1);
    
 channeluses=0;
    
 myStream = RandStream('mt19937ar','seed',initial);
 RandStream.setGlobalStream(myStream);
    
 
     
 while min(Errors_per_layer)<maxerrors
        
       
       
        channeluses = channeluses + 1;
        
        
 
        transmitbits=randi([0,1],Nt,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
                     
      
        s=x( bi2de(transmitbits) + 1);   % Mapping and Modulation
       
            
   
        
        
      
        if channelchange == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % the channel changes at every use
            
        elseif mod(channeluses,channelchange) == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % make new channel
            
        end
        
        
    
        n=complex(sqrt(No/2)*randn(Nr,1),sqrt(No/2)*randn(Nr,1));
        
      
        y=sqrt(p)*H*s + n;
             

        [Q,R] = qr(H);
        
        yy=(Q')*y;
        sestimate=zeros(Nt,1);
        indestimate=zeros(Nt,1);
        
        for l=Nt:-1:1
            
            sestimate(l+1:Nt)=s(l+1:Nt);
            clear M;
            clear testind;
            yyy(l)=yy(l)-sqrt(p)*R(l,:)*sestimate;
            metric=real(yyy(l)*conj(R(l,l)*x)); 
            [M,testind]=max(metric);
            indestimate(l)=testind;
            sestimate(l)=x(indestimate(l));
            
            if tf == 1
                
                step(con{l},yyy(l))
                
            end
            
        
        end
        
        
        
        

        
        receivedbits= de2bi(indestimate-1,3);
        
        
        Bits_simulated_per_layer= 3*channeluses
        
        Total_bits_simulated= Bits_simulated_per_layer*Nt
        
        
        Errors_per_layer = Errors_per_layer + sum(abs(transmitbits-receivedbits),2)
        
        
        Current_BER_per_layer= Errors_per_layer./Bits_simulated_per_layer
        
       
        
       
        
 end
    
    
    
    
    
   
BER=Current_BER_per_layer;
    
X=['Eb/No = ',num2str(SNRdB) ];
disp(X) 



for i=1:Nt
    
    Y =[ 'BER for Layer ',num2str(i), ' = ', num2str(BER(i))];
    disp(Y)
    
end




