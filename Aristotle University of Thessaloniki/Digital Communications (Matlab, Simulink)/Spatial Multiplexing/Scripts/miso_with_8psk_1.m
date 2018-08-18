prompt= 'Number of transmit antennas = ';
Nt = input(prompt);

Nr=1;


prompt= 'Average Eb/No = ';
SNRdB = input(prompt);



prompt= 'Maximum errors to stop = ';
maxerrors = input(prompt);

prompt= 'View constellation diagrams: ';
checkconstellation = input(prompt);

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


tf = strcmp(checkconstellation,'Yes');
if tf == 1
   con=cell(1,Nt);

   for i=1:Nt
    
   
       X = ['Constellation Diagram for the channel ',num2str(i)];
      con{i} = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
      'XLimits',[-80 80],'YLimits',[-80 80]);
   end

   X = 'Constellation Diagram of the total signal at the receive antenna) ';
   cons = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
   'XLimits',[-100 100],'YLimits',[-100 100]);
end

rdB= SNRdB + 10*log10(3*Nt); % SNR/receive antenna
    
    
    
r=10.^(rdB/10);
    
errors=0;
    
channeluses=0;
    
myStream = RandStream('mt19937ar','seed',initial);
RandStream.setGlobalStream(myStream);
    
 
    
while errors<maxerrors
        
       
       
        channeluses = channeluses + 1;
        
        
 
        bits=randi([0,1],Nt,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
        
        
        transmitbits=reshape(bits',1,3*Nt);
            
            
      
        s=x( bi2de(bits) + 1);   % Mapping and Modulation
            
   
        
        
      
        if channelchange == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % the channel changes at every use
            
        elseif mod(channeluses,channelchange) == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % make new channel
            
        end
        
        
    
        n=complex(sqrt(No/2)*randn(Nr,1),sqrt(No/2)*randn(Nr,1));
        
      
        y=sqrt(r)*H*s + n;
        
        
        if tf == 1
            
        
           for l=1:Nt
            
               step(con{l},sqrt(r)*H(l)*s(l) + n)
            
           end
        
        
           step(cons,y)
        end
        
        for l=0:2^(3*Nt)-1
            
            testbits= de2bi(l,3*Nt);
            testsymbols= x(bi2de(reshape(testbits,3,Nt)')+1);
            metric(l+1) = (norm(y-sqrt(r)*H*testsymbols, 'fro')).^2;
            
        end
        
           
        
        clear M;
        clear ind;
        
        [M,ind] = min(metric);
        
        receivedbits= de2bi(ind-1,3*Nt);
        
        
       
        Bits_simulated= 3*Nt*channeluses
        
        
        errors = errors + nnz(transmitbits-receivedbits)
        
        
        Current_BER=errors/Bits_simulated
        
       
       
        
end
    
    
    
    
    
X=['Eb/No = ',num2str(SNRdB) ];
disp(X) 


BER=Current_BER;

X=['BER = ',num2str(BER) ];
disp(X) 



 
        
        
        
        
        
        
        
                    
                
        
        
            
    




