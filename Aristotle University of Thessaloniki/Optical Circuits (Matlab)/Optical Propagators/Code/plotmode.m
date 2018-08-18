function plotmode(index)

%This function called with input i (0==calculate , 1==plot & calculate mode) and with global variables and handles
%from the GUI , computes ,with the aid of disper, the n-effective , the percentage of
%the power guided and the Electical Field (profile) of the mode requested

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mis h_mode h_neff h_pguid h_pevan h_err h_pop_wave ...
    h_pop_h h_pop_map h_coffr h_cutsiz  h_modnum;

%Speed of light in free-space
Co = 2.9979 * 10^8 ;

%Magnetic Diaperatotita
mio = 4 * pi * 10^-7 ;

%The Mode that we want to display
num  = str2num(get(h_mode,'String'));

%The MonoChromatic Response & Structural Parameters
n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));
wave = str2num(get(h_wave,'String'));

%Error Check -> Case of empty matrix result
err = [ n1 n2 h wave num];
if length(err) ~=5
    set(h_err,'String','Invalid Input(s) => Please Correct Expression')
    error('String','Invalid Input(s) => Please Correct Expression')
end

%Define the unit-size of Wavelength
val = get(h_pop_wave,'Value');
if val == 1
    wave = wave * 10^-3 ; %milli meters
elseif val == 2
    wave = wave * 10^-6 ; %micro meters
elseif val == 3
    wave = wave * 10^-9 ; %nano  meters
end

%Define the unit-size of Guiding Layer Height
val = get(h_pop_h,'Value');
if val == 1
    h = h * 10^-3 ; %milli meters
elseif val == 2
    h = h * 10^-6 ; %micro meters
elseif val == 3
    h = h * 10^-9 ; %nano  meters
end

omega = 2*pi*Co/wave;
V = omega * h * sqrt(n1^2 - n2^2) / (2*Co); 
NoM = floor(2*V/pi) + 1;

%Error check for very small V --> TE-0 mode very close to cut-off
if V < 2*10^-8
    set(h_err,'String','Algorithm Unsuccesful => TE.0 Mode Guided Power = 0% , n-eff = n2')
end

%Error Check regarding num -> Mode requested to display
if (num > NoM) | (num < 1) | ((round(num) - num)~=0) | isempty(num)
    set(h_err,'String','Invalid TE Mode Requested To Plot & Calculate')
    error('Invalid TE mode Requested To Plot & Calculate')   
end

%Call the disper to get the beta,neff,num_max,missed of the desired mode
[ beta , n_eff , num_max ] = disper( omega , h , n1 , n2 );

%Free-space wave-number
ko = omega / Co;
%Wave-number in guiding layer (kappa) and in substrate/Cladding (gamma)
kappa  = ko * sqrt( n1^2 - n_eff.^2 );
gamma  = ko * sqrt( n_eff.^2 - n2^2 );
phi = atan(gamma./kappa);
x1 = linspace( 0  , h   , 5000);
x2 = linspace( -h , 0   , 100);
x3 = linspace( h  , 2*h , 100);

%The magnitude of the electric field in all the layers - Normalized by Eo
E_Guid = cos( kappa' * x1 - phi' * ones(size(x1)) );
E_Subs = cos(phi)' * ones(size(x2)) .* exp( gamma' * x2 );
E_Clad = cos(kappa*h - phi)' * ones(size(x3)) .* exp(-gamma' * (x3 - h));

%Power as Integral (analytically done) of the Pointing Vector in all the waveguide layers
%Normalized by the factor Eo^2 - where Eo is the maximum electric field in the guiding layer
for i=1:num_max
    Power_Guid(i) = beta(i) / (2*omega*mio) * h ; 
    Power_Subs(i) = beta(i) * kappa(i)^2 / (2*gamma(i)) / (kappa(i)^2 + gamma(i)^2) / (2*omega*mio);
    Power_Clad(i) = Power_Subs(i);
end
Power_Whole = Power_Guid + Power_Subs + Power_Clad; 

%Percentages of the power guided and evanescent
P_Guided = Power_Guid ./ Power_Whole ;
P_Evanes = (Power_Clad + Power_Subs) ./ Power_Whole ;


%If calculation or ploting was requested
if index == 0 | index == 1
    %Cut-Off Frequency of Requested Mode
    cutoff = (num-1) * Co / ( 2 * h * sqrt( n1^2 - n2^2 ) );
    if (cutoff > 10^9) & (cutoff< 10^12)
        set( h_coffr , 'String' , sprintf('%3.3f',cutoff/10^9 ))
        set( h_cutsiz , 'String' , '[GHz]:' )
    elseif (cutoff > 10^12) & (cutoff < 10^15)
        set( h_coffr , 'String' , sprintf('%3.3f',cutoff/10^12 ))
        set( h_cutsiz , 'String' , '[THz]:' )
    elseif (cutoff > 10^15) & (cutoff < 10^18)
        set( h_coffr , 'String' , sprintf('%3.3f',cutoff/10^15 ))
        set( h_cutsiz , 'String' , '[PHz]:' )
    else
        set( h_coffr , 'String' , sprintf('%1.3g',cutoff ))
        set( h_cutsiz , 'String' , '[Hz]:' )
    end
    %Return the values of n-effective and power_guided of the mode requested to the edit boxes
    set( h_modnum,'String',sprintf('TE-%d Mode',num-1))
    set(h_neff,'String',sprintf('%2.6f',n_eff(num)))
    set(h_pguid,'String',sprintf('%3.6f',P_Guided(num)*100))
    %set(h_pevan,'String',sprintf('%3.6f',P_Evanes(num)*100))
end

%If only plot was requested
if index == 1
    %Fancy Plot Parameters
    z1 = 0*x1;
    z2 = 0*x2;
    z3 = 0*x3;
    c1 = ( E_Guid(num,:) );
    c2 = ( E_Subs(num,:) );
    c3 = ( E_Clad(num,:) );
    
    %Plot the profile of the mode
    set(gca,'nextplot','replace')
    fill([0 h h 0],[-1 -1 1 1],[0.85 0.85 0.85]);
    hold on
    %plot(x1,E_Guid(num,:),'b',x2,E_Subs(num,:),'b',x3,E_Clad(num,:),'b','LineWidth',2.5);
    surface([x1;x1],[E_Guid(num,:);E_Guid(num,:)],[z1;z1],[c1;c1],'facecolor','none','edgecolor','flat','linewidth',3)
    hold on
    surface([x2;x2],[E_Subs(num,:);E_Subs(num,:)],[z2;z2],[c2;c2],'facecolor','none','edgecolor','flat','linewidth',3)
    hold on
    surface([x3;x3],[E_Clad(num,:);E_Clad(num,:)],[z3;z3],[c3;c3],'facecolor','none','edgecolor','flat','linewidth',3)
    hold on
    plot([0,0],-1:2:1,'k',[h,h],-1:2:1,'k','LineWidth',4)
    hold on
    plot([h/2,h/2],-1:2:1,'k-.',-h:3*h:2*h, [0,0],'k-.','LineWidth',2)
    hold on
    axis([-h 2*h -1 1])
    grid on
    set(gca,'Layer','Top')
    hold off
    title_text = sprintf('TE.%d Mode Profile',num-1);
    title(title_text,'FontSize',12,'FontWeight','Bold')
    
    %Determine Colormap to use
    val = get(h_pop_map,'Value');  
    if val == 1
        eval('colormap(winter(64))');
    elseif val ==2
        eval('colormap(spring(64))');
    elseif val ==3
        eval('colormap(summer(64))');
    elseif val ==4
        eval('colormap(autumn(64))');
    elseif val ==5
        eval('colormap(jet(64))');
    elseif val ==6
        eval('colormap(hsv(64))');
    elseif val ==7
        eval('colormap(hot(64))');
    end
end

%Estimate NumberOfModes before calling disper. If NoM > 600 , disper gets stuck
V = omega*h*sqrt(n1^2 - n2^2)/(2*Co);
NoM = floor(2*V/pi) + 1 ;
if NoM >600
    set(h_err,'String','Too many modes develloped ==> Algorithm Unsuccesful')
    disp('Number of modes develloped :')
    disp(num_max)
    error('>>>>>Too many modes develloped ==> EXTREMELY LONG processing time<<<<<<')
end
