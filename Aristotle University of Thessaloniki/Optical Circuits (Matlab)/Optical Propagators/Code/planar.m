function planar(command_string)

if nargin == 0
    command_string = 'initialize';
end

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mode h_neff h_pguid h_pevan ...
    h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_wave h_pop_freq h_ndiff h_pop_map h_coffr h_cutsiz  h_modnum;

Co = 2.9979 * 10^8;

 
%Initialize the GUI
if strcmp(command_string,'initialize')
    %Make sure only one GUI exists
    h_figs = get(0,'children');
    fig_exists = 0;
    for fig = h_figs'
        fig_exists = strcmp( get(fig,'name') , 'Planar Dielectric Waveguide' );
        if fig_exists
            figure(fig); %If it exists it's brought back forth
            return; %no need to initialize, exit
        end
    end
    
    h_fig = figure('NumberTitle','off','name','Symmetrical Planar Dielectric Waveguide (Slab Waveguide)','units','normalized','Position',[0 0.015 1 0.95]);
    set(h_fig,'DefaultUicontrolFontSize',12')
        
    axes('position',[0.1 0.05 0.8 0.5])
    
    %Create The Structural Input FRAME & STATIC TEXT
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.04 0.82 0.45 0.16])
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.05 0.96 0.2  0.04])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.06 0.966 0.18  0.032],'String','Structural Input','FontSize',14,'FontWeight','Bold')
    uicontrol(h_fig,'Units','Normalized','Position',[0.05 0.92 0.16 0.03],'String','Refractive Indices','HorizontalAlignment','Left','Style','Text','FontWeight','demi') 
    uicontrol(h_fig,'Units','Normalized','Position',[0.05 0.88 0.16 0.03],'String','Guiding Layer            (n1):','HorizontalAlignment','Left','Style','Text') 
    uicontrol(h_fig,'Units','Normalized','Position',[0.05 0.84 0.16 0.03],'String','Substrate/Cladding (n2):','HorizontalAlignment','Left','Style','Text') 
    uicontrol(h_fig,'Units','Normalized','Position',[0.30 0.88 0.17 0.03],'String','Guiding Layer Height','HorizontalAlignment','Left','Style','Text','FontWeight','demi') 
    uicontrol(h_fig,'Units','Normalized','Position',[0.30 0.84 0.03 0.03],'String','(h):','HorizontalAlignment','Left','Style','Text') 
    uicontrol(h_fig,'Units','Normalized','Position',[0.30 0.91 0.12 0.06],'String','Relative Refractive Index Difference (%)','HorizontalAlignment','Left','Style','Text')
    h_ndiff = uicontrol(h_fig,'Units','Normalized','Position',[0.425 0.93 0.05 0.03],'String','6.666' ,'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    
    %Create The Structural Input Edit-Boxes
    h_n1 = uicontrol(h_fig,'CallBack','planar(''calcdiff'');','Units','Normalized','Position',[0.2 0.885 0.07 0.03],'String','1.5' ,'Style','Edit','BackGroundColor','white');
    h_n2 = uicontrol(h_fig,'CallBack','planar(''calcdiff'');','Units','Normalized','Position',[0.2 0.845 0.07 0.03],'String','1.4' ,'Style','Edit','BackGroundColor','white');
    h_h  = uicontrol(h_fig,'Units','Normalized','Position',[0.325 0.845 0.08 0.03],'String','10','Style','Edit','BackGroundColor','white');
    
    %Create The Structural Input POP-UP menu for the h height
    h_pop_h = uicontrol(h_fig,'style','popup','units','normalized','position',[0.415 0.845 0.06 0.03],'string','mm|ìm|nm|m','BackGroundColor','white');
    set(h_pop_h,'Value',2)
        
    %Create the MonoChromatic Response FRAME & STATIC TEXT <---- First Step(Before Calculate Number Of Modes PUSH BUTTON)
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.52 0.79 0.45 0.19])
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.53 0.96 0.32  0.04])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.54 0.966 0.3  0.032],'String','MonoChromatic Response','FontSize',14,'FontWeight','Bold')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.92 0.085 0.03],'String','Wavelength :','HorizontalAlignment','Left')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.88 0.085 0.03],'String','Frequency   :','HorizontalAlignment','Left')
    h_wave = uicontrol(h_fig,'CallBack','planar(''wavtofreq'');','Units','Normalized','Position',[0.62 0.925 0.1 0.03],'String','1' ,'Style','Edit','BackGroundColor','white');
    h_freq = uicontrol(h_fig,'CallBack','planar(''freqtowav'');','Units','Normalized','Position',[0.62 0.885 0.1 0.03],'String','299.79','Style','Edit','BackGroundColor','white');
    
    %Create the synchronization with the dispersion graph
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.800 0.88  0.16  0.07])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.805 0.888 0.15 0.05],'String','Synchronize     with Max Dispersion Frequency','HorizontalAlignment','Left','FontAngle','italic')
    uicontrol(h_fig,'CallBack','planar(''sync'');','Units','Normalized','Position',[0.805 0.915 0.08 0.03],'Style','Pushbutton','String','Synchronize');
        
    %Create the POP UP MENUS for Wavelength & Frequency unit-size
    h_pop_wave = uicontrol(h_fig,'style','popup','CallBack','planar(''wavetofreq'')','units','normalized','position',[0.73 0.925 0.06 0.03],'string','mm|ìm|nm|m','BackGroundColor','white');
    set(h_pop_wave,'Value',2)
    h_pop_freq = uicontrol(h_fig,'style','popup','CallBack','planar(''freqtowav'')','units','normalized','position',[0.73 0.885 0.06 0.03],'string','GHz|THz|PHz|Hz','BackGroundColor','white');
    set(h_pop_freq,'Value',2)    
    
    %Create the Calculate Number Of Modes PUSH BUTTON
    h_cnom = uicontrol(h_fig,'CallBack','planar(''calculate_nom'');','Units','Normalized','Position',[0.8 0.845 0.16 0.03],'Style','Pushbutton','String','Number of Modes');
    
    %Create the MonoChromatic Response FRAME & STATIC TEXT <---- Second Step(After Calculate Number Of Modes PUSH BUTTON)
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.84 0.2 0.03],'String','Number of TE-Modes :','HorizontalAlignment','Left')
    h_nom = uicontrol(h_fig,'Units','Normalized','Position',[0.71 0.845 0.08 0.03],'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.80 0.2 0.03],'String','Select TE-Mode to Calculate :','HorizontalAlignment','Left')
    h_mode = uicontrol(h_fig,'Units','Normalized','Position',[0.71 0.805 0.08 0.03],'Style','Edit','BackGroundColor','white');
    
    %Create the Calculate & Display this Mode PUSH BUTTONs
    h_cnom = uicontrol(h_fig,'CallBack','planar(''calc_mode'');','Units','Normalized','Position',[0.8 0.805 0.075 0.03],'Style','Pushbutton','String','Calculate');
    h_dnom = uicontrol(h_fig,'CallBack','planar(''disp_mode'');','Units','Normalized','Position',[0.885 0.805 0.075 0.03],'Style','Pushbutton','String','Display');
    
    %Create the MonoChromatic Response FRAME & STATIC TEXT <---- Third Step(After Calculate&Display This Mode PUSH BUTTON)
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.52 0.705 0.45 0.09])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.665 0.75 0.25 0.03],'String','Effective Refractive Index (n-effective):','HorizontalAlignment','Left')
    %uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.71 0.1 0.03],'String','(n-effective) :','HorizontalAlignment','Left')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.775 0.71 0.16 0.03],'String','Guided Power (%):','HorizontalAlignment','Left')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.53 0.71 0.11 0.03],'String','Cut-Off Frequency','HorizontalAlignment','Left')
    h_cutsiz = uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.64 0.71 0.04 0.03],'String',' ');
    %uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.74 0.71 0.16 0.03],'String','Evanescent Power (%):','HorizontalAlignment','Left')
    h_neff  = uicontrol(h_fig,'Units','Normalized','Position',[0.89 0.755 0.07 0.03],'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    h_pguid = uicontrol(h_fig,'Units','Normalized','Position',[0.89 0.715 0.07 0.03],'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    h_coffr = uicontrol(h_fig,'Units','Normalized','Position',[0.69 0.715 0.07 0.03],'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    %h_pevan = uicontrol(h_fig,'Units','Normalized','Position',[0.88 0.715 0.08 0.03],'Style','Edit','BackGroundColor',[0.85 0.85 0.85]);
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.525 0.745 0.12 0.04],'BackGroundColor',[0.85 0.85 0.85])
    h_modnum = uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.527 0.750 0.115  0.03],'String','No Mode','HorizontalAlignment','Center', ...
        'FontAngle','italic','fontweight','bold','BackGroundColor',[0.85 0.85 0.85]);
   
    
    %Create the STATIC TEXT & FRAME of Errors and Remarks box
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.52 0.61 0.45 0.06])
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.53 0.65 0.25 0.04])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.54 0.66 0.22 0.028],'String',' Errors and Remarks','FontSize',14,'FontWeight','Bold')
    h_err = uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.54 0.615 0.42 0.03],'String',' None So Far ','ForeGroundColor','r','HorizontalAlignment','Left');
    
    %Create the STATIC TEXT & FRAMES for Dispersion box
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.04 0.61 0.45 0.17])
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.05 0.76 0.22  0.04])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.06 0.768 0.206 0.03],'String','Dispersion Graphs','FontSize',14,'FontWeight','Bold')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.05 0.71 0.21 0.03],'String','Normalized Frequency (V) [rad] :','HorizontalAlignment','Left')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.05 0.67 0.21 0.03],'String','Angular Velocity (ù)     [rad/sec] :','HorizontalAlignment','Left')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.32 0.74 0.1 0.03],'String','Desired Range')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.37 0.71 0.01 0.03],'String','to')
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.37 0.67 0.01 0.03],'String','to')
        
    %Create the EDIT-BOXES for the Dispersion part
    h_v1 = uicontrol(h_fig,'CallBack','planar(''v1too1'');','Units','Normalized','Position',[0.265 0.71 0.09 0.03],'String','0' ,'Style','Edit','BackGroundColor','white');
    h_v2 = uicontrol(h_fig,'CallBack','planar(''v2too2'');','Units','Normalized','Position',[0.390 0.71 0.09 0.03],'String','12' ,'Style','Edit','BackGroundColor','white');
    h_o1 = uicontrol(h_fig,'CallBack','planar(''o1tov1'');','Units','Normalized','Position',[0.265 0.67 0.09 0.03],'String','0' ,'Style','Edit','BackGroundColor','white');
    h_o2 = uicontrol(h_fig,'CallBack','planar(''o2tov2'');','Units','Normalized','Position',[0.390 0.67 0.09 0.03],'String','1.34e+015' ,'Style','Edit','BackGroundColor','white');
    
    %Create the PUSH-BUTTON for normalized/specialized dispersion
    h_norm = uicontrol(h_fig,'CallBack','planar(''normalized'');' ,'Units','Normalized','Position',[0.265 0.62 0.1 0.04],'Style','Pushbutton','String','Normalized');
    h_spec = uicontrol(h_fig,'CallBack','planar(''specialized'');','Units','Normalized','Position',[0.38 0.62 0.1 0.04],'Style','Pushbutton','String','Specialized');
    
    %Create FRAME,TEXT & PUSH BUTTON for synchronize the dispersion plot
    uicontrol(h_fig,'Style','Frame','Units','Normalized','Position',[0.045 0.62  0.215  0.04])
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.13 0.63 0.124 0.02],'String','with MonoChromatic','HorizontalAlignment','Left','FontAngle','italic')
    uicontrol(h_fig,'CallBack','planar(''sync2'');','Units','Normalized','Position',[0.05 0.625 0.08 0.03],'Style','Pushbutton','String','Synchronize');
    
    
    %Initialization 'look' of the axes
    h = eval(get(h_h,'String'));
    x1 = linspace( 0  , h   , 100);
    x2 = linspace( -h , 0   , 100);
    x3 = linspace( h  , 2*h , 100);
    fill([0 h h 0],[-1 -1 1 1],[0.85 0.85 0.85]);
    hold on
    plot([0,0],-1:2:1,'k',[h,h],-1:2:1,'k','LineWidth',4)
    hold on
    plot([h/2,h/2],-1:2:1,'k-.',-h:3*h:2*h, [0,0],'k-.','LineWidth',2)
    hold on
    axis([-h 2*h -1 1])
    grid on
    text(0,0,'\leftarrow','FontSize',70)
    text(0.67*h,0,'\rightarrow','FontSize',70)
    text(0.4*h,0,'h','FontSize',70)
    text(0.08*h,0.7,'Guiding Layer : n1','FontSize',20)
    text(-0.82*h,0.7,'Substrate : n2','FontSize',20)
    text(1.2*h,0.7,'Cladding : n2','FontSize',20)
    set(gca,'Layer','Top')
    hold off
    
    %Create the Colormap-to-use POP-UP menu
    uicontrol(h_fig,'Style','Text' ,'Units','Normalized','Position',[0.77 0.555 0.12 0.05],'String','Select Colormap for Display:',...
        'BackGroundColor',get(h_fig,'Color'),'FontWeight','Bold','FontAngle','italic','fontsize',10,'horizontalalignment','right')
    h_pop_map = uicontrol(h_fig,'style','popup','units','normalized','position',[0.9 0.57 0.07 0.03],'string','winter|spring|summer|autumn|jet|hsv|hot','BackGroundColor','white');
    set(h_pop_map , 'Value' , 5 );

    
%Changes relative refractive index difference if either n1 or n2 is altered   
elseif strcmp(command_string,'calcdiff')
    error_check;
    n1 = str2num( get(h_n1,'String') ); 
    n2 = str2num( get(h_n2,'String') );
    diff = 100 * (n1 - n2) / n1;
    if diff ~= str2num( get(h_ndiff,'String') )
        set(h_ndiff,'String',sprintf('%2.3f',diff))
    end
    
%Synchromize the MonoChromatic Freq with the max omega freq of Dispersion Parameters
elseif strcmp(command_string,'sync')
    error_check;
    sync;

%Synchromize the Max Omega/V of Dispersion with the MonoChromatic Freq
elseif strcmp(command_string,'sync2')
    error_check;
    sync2;
    
%Changes frequency if wavelength is altered   
elseif strcmp(command_string,'wavtofreq')
    error_check;
    wavtofreq(1);
    
%Changes  wavelength if frequency is altered   
elseif strcmp(command_string,'freqtowav')
    error_check;
    wavtofreq(0);

%Change Omegas if Vs are altered
elseif strcmp(command_string,'v1too1') | strcmp(command_string,'v2too2')
    error_check;
    vtoomega;

%Change Vs if Omegas are altered  
elseif strcmp(command_string,'o2tov2') | strcmp(command_string,'o1tov1')
    error_check;
    omegatov;

%Calculates number of modes present
elseif strcmp(command_string,'calculate_nom')
    error_check;
    calculate_nom;

%Calculates Desired Mode
elseif strcmp(command_string,'calc_mode')
    error_check;
    plotmode(0);
    
%Plots Desired Mode
elseif strcmp(command_string,'disp_mode')
    error_check;
    plotmode(1);
    
%Plots Normalized Dispersion graph
elseif strcmp(command_string,'normalized')
    error_check;
    plotnorm;
    
%Plots the Regular Dispersion graph
elseif strcmp(command_string,'specialized')
    error_check;
    plotspec;
    
end