function t1(command_string)

%This function plots the normalized characteristic qquation of TE-modes on a symmetrical planar dielectric waveguide 

global h_V  h_b0  h_b1   h_bs  h_axlim  h_nom  h_dotlin h_infis h_zero;

if nargin == 0
    command_string = 'initialize';
end
 
%Initialize the GUI
if strcmp(command_string,'initialize')
    %Make sure only one GUI exists
    h_figs = get(0,'children');
    fig_exists = 0;
    for fig = h_figs'
        fig_exists = strcmp( get(fig,'name') , 'Normalized Characteristic Equation of TE-Modes of a SPDWG' );
        if fig_exists
            figure(fig); %If it exists it's brought back forth
            return; %no need to initialize, exit
        end
    end
    
    h_fig = figure('NumberTitle','off','name','Normalized Characteristic Equation of TE-Modes of a SPDWG','units','normalized','Position',[0 0.015 1 0.95]);
    set(h_fig,'DefaultUicontrolFontSize',12')
        
    axes('position',[0.1 0.05 0.8 0.8])
    
    uicontrol(h_fig,'style','text','units','normalized','position',[0.05 0.95 0.1 0.03],'string','Normalized  V','BackgroundColor',[0.8 0.8 0.8])
    uicontrol(h_fig,'style','text','units','normalized','position',[0.2 0.95 0.1 0.03],'string','NumberOfModes','BackgroundColor',[0.8 0.8 0.8])
    uicontrol(h_fig,'style','text','units','normalized','position',[0.35 0.95 0.1 0.03],'string','Start b [0,1]','BackgroundColor',[0.8 0.8 0.8])
    uicontrol(h_fig,'style','text','units','normalized','position',[0.5 0.95 0.1 0.03],'string','Stop b  [0,1]','BackgroundColor',[0.8 0.8 0.8])
    uicontrol(h_fig,'style','text','units','normalized','position',[0.65 0.95 0.1 0.03],'string','Number of bs ','BackgroundColor',[0.8 0.8 0.8])
    uicontrol(h_fig,'style','text','units','normalized','position',[0.8 0.95 0.1 0.03],'string','Axes Limits  ','BackgroundColor',[0.8 0.8 0.8])
    
    h_V = uicontrol(h_fig,'style','edit','units','normalized','position',[0.05 0.92 0.1 0.03],'string','12','BackgroundColor','w');
    h_nom = uicontrol(h_fig,'style','edit','units','normalized','position',[0.2 0.92 0.1 0.03],'string','?');
    h_b0 = uicontrol(h_fig,'style','edit','units','normalized','position',[0.35 0.92 0.1 0.03],'string','0','BackgroundColor','w');
    h_b1 = uicontrol(h_fig,'style','edit','units','normalized','position',[0.5 0.92 0.1 0.03],'string','1','BackgroundColor','w');
    h_bs = uicontrol(h_fig,'style','edit','units','normalized','position',[0.65 0.92 0.1 0.03],'string','10000','BackgroundColor','w');
    h_axlim = uicontrol(h_fig,'style','edit','units','normalized','position',[0.8 0.92 0.1 0.03],'string','30','BackgroundColor','w');
    
    uicontrol(h_fig,'style','push','units','normalized','position',[0.92 0.9 0.06 0.08],'string','Plot','Callback','t1(''plot'')')
    
    h_dotlin = uicontrol(h_fig,'style','checkbox','units','normalized','position',[0.92 0.815 0.08 0.03],'Max',1,'Min',0,'Value',1,...
        'String','Dot/Line','BackgroundColor',[0.8 0.8 0.8]);
    h_zero = uicontrol(h_fig,'style','checkbox','units','normalized','position',[0.92 0.79 0.08 0.03],'Max',1,'Min',0,'Value',1,...
        'String','Zero-Line','BackgroundColor',[0.8 0.8 0.8]);
    h_infis = uicontrol(h_fig,'style','checkbox','units','normalized','position',[0.92 0.765 0.08 0.03],'Max',1,'Min',0,'Value',1,...
        'String','Infinities','BackgroundColor',[0.8 0.8 0.8]);
    
    
elseif strcmp(command_string,'plot')
    V = str2num(get(h_V,'string'));
    b0 = str2num(get(h_b0,'string'));
    b1 = str2num(get(h_b1,'string'));
    bs = str2num(get(h_bs,'string'));
    axlim = str2num(get(h_axlim,'string'));
    NoM = ceil(2*V/pi);
    set(h_nom,'String',sprintf('%d',NoM))
    
    for k=0:NoM-1;
        b_inf_tan(k+1) = 1 - (  ( (2*k+1) * pi )/ ( 4 * V )    )^2 ;
    end
    if b_inf_tan( NoM )<0
        b_inf_tan( NoM ) = 0;
    end
    b_inf_tan( NoM+1 ) = 0.5;
    b_infs = sort(b_inf_tan);
  
    b = linspace(b0 , b1 , bs);
    XE =  tan( 2 * V * sqrt(1-b) ) -  ( 2 * sqrt(b - b.^2) ./ (1 - 2*b) );;
    
    if get(h_dotlin,'Value') == 1
        h = plot(b,XE,'bo');
        set(h,'MarkerSize',4,'MarkerFaceColor','b')
    else
        h = plot(b,XE,'b','LineWidth',2);
    end    
    axis([b0  b1  -axlim axlim])
    grid on
    hold on
    if get(h_zero,'Value') == 1
        plot([0 1] , [ 0 0 ] ,'r','LineWidth',3)
    end
    if get(h_infis,'Value') == 1
        for i=1:length(b_infs)
            h1 = plot( [ b_infs(i) b_infs(i) ] , [ -axlim axlim ] , 'LineWidth' , 2 );
            set(h1,'Color',[0.1 0.7 0.2])
            hold on
        end
    end
    if get(h_infis,'Value') == 1 
       str1 = 'Infinities';
    else
       str1 = num2str([]);
    end
    if get(h_zero,'Value') == 1
        str2 = 'Zero-Line';
    else
        str2 = num2str([]);
    end
    legend('XE(V,b)',str2,str1)
    xlabel('Normalized phase constant b','FontSize',12)
    ylabel('XE(V,b)','FontSize',12)
    title(sprintf('Characteristic Equation at V = %d ', V) , 'FontSize',16)
    hold off
    
end
    