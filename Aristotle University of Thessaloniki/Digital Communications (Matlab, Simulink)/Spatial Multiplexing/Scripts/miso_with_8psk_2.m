prompt= 'Number of transmit antennas = ';
Nt = input(prompt);

Nr=1;



prompt= 'Áverage Eb/No = ';
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



transmitbits=zeros(1,3);
receivedbits=zeros(1,3);



x=(1/sqrt(Nt)).*[1 ; exp(-(pi/4)*(1i));  exp((3*pi/4)*(1i));  -1 ; exp((pi/4)*(1i)); exp(-(pi/2)*(1i)); exp((pi/2)*(1i)); exp(-(3*pi/4)*(1i))];
%  8-PSK Constellation with Gray Bit-Mapping so that x(1)=000 , x(2) = 100 , x(3) = 010 , x(4) = 110 
%, x(5) = 001 , x(6) = 101 , x(7) = 011 , x(8)=111 ... x( kdecimal + 1) = kbinary

tf = strcmp(checkconstellation,'Yes');

if tf == 1


   con=cell(1,Nt);

   for i=1:Nt
    
   
       X = ['Constellation Diagram for the channel ',num2str(i)];
      con{i} = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
      'XLimits',[-3 3],'YLimits',[-3 3]);
   end

   X = 'Constellation Diagramm at the receive antenna ';
   cons = comm.ConstellationDiagram('Name', X,'ReferenceConstellation',x, 'SymbolsToDisplaySource','Property','SymbolsToDisplay', 10^30,...
    'XLimits',[-6 6],'YLimits',[-6 6]);

end


    
    
rdB= SNRdB + 10*log10(3); % SNR/receive antenna
    
    
    
r=10.^(rdB/10);
    
errors=0;
    
channeluses=0;
    
myStream = RandStream('mt19937ar','seed',initial);
    
RandStream.setGlobalStream(myStream);
    
 
absfading=[];
anglefading=[];
 
while errors<maxerrors
        
       
       
        channeluses = channeluses + 1;
        
        
 
        bits=randi([0,1],1,3);  % Nt binary 3-tuples each one corresponds to one transmit antena
            
        
        
        transmitbits=bits;
            
            
      
        s=x( bi2de(bits) + 1);   % Mapping and Modulation
            
   
        
        
      
        if channelchange == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % the channel changes at every use
            
        elseif mod(channeluses,channelchange) == 1
            
            H=complex(sqrt(Ehij2/2)*randn(Nr,Nt),sqrt(Ehij2/2)*randn(Nr,Nt)); % make new channel
            
        end
        
        
    
        n=complex(sqrt(No/2)*randn(Nr,1),sqrt(No/2)*randn(Nr,1));
        
        h= sum(H);
        y=sqrt(r)*h*s + n;
        
        if tf==1
            
        
           for l=1:Nt
             
               step(con{l},sqrt(r)*H(l)*s+n)
            
           end

           step(cons,y)
           
        end
        
        if length(absfading) < 8000
            
           absfading=[absfading ; abs(h) abs(H)];
           anglefading=[anglefading ; angle(h) angle(H)];
           
        end
        
        
        
        metric = (abs(y-sqrt(r)*h*x)).^2;
        
        
        clear M;
        clear ind;
        
        [M,ind] = min(metric);
        
        receivedbits= de2bi(ind-1,3);
        
        
        Bits_simulated= 3*channeluses
        
        
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
for i=1:Nt+1
    
    
  
    plot(absfading(:,i))
    
    title(C)
    xlabel('Channel uses')
    ylabel('Absolute value of the fading coefficients')
    
    
    grid on
    
    
    axis([0,a,-Inf,Inf])
    
    
    hold on
    
    
end
 
        
Y=cell(1,Nt+1);
Y{1}='Total signal at the receive antenna';
for i=2:Nt+1
    
    Y{i}=[ 'Channel ',num2str(i-1)];
end


legend(Y,'Location','northoutside','Orientation','horizontal' )

C=['Phase of the fading coefficients for the first ',num2str(a),' channel uses'];

figure
        
anglefading= anglefading*180/pi;

for i=1:Nt+1
    
    
  
    plot(anglefading(:,i))
    
    title(C)
    xlabel('Channel uses')
    ylabel('Phase of the fading coefficients ( degrees)')
   
    
    grid on
    
    
    axis([0,a,-Inf,Inf])
    
    
    hold on
    
    
end
 
        
legend(Y,'Location','northoutside','Orientation','horizontal' )      
        
        
                    
                
        
        
            
    




