function plotnorm

global h_n1 h_n2 h_h  h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_map;

%This Function Creates the Normalized Dispersion graph

%Speed of light in Free-Space
Co = 2.9979 * 10^8 ;

%Take Primary  Input from edit-text boxes
n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));
v1 = str2num(get(h_v1,'String')); 
v2 = str2num(get(h_v2,'String'));

%Error Check -> Case of Empty Matrix
err = [n1 n2 h v1 v2];
if length(err) ~=5
    set(h_err,'String','Invalid Input(s) => Expression is not a number')
    error('Invalid Input(s) => Expression is not a number')
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

%This is used to un-normalize the V => omega , because disper function needs omegas as inputs
aux  = h*sqrt(n1^2 - n2^2)/(2*Co); 
omega1 = v1 / aux;
omega2 = v2 / aux;
omega = linspace(omega1,omega2,100) ; %Number of freq steps used == 100

%Call on the dispersion0 function
[ beta , n_effective , num_max , missed ] = disper0( omega , h , n1 , n2 );

%Normalized graph parametres
V = omega * h * sqrt(n1^2 - n2^2) / 2 / Co ;
b = ( ( n_effective ).^2 - n2^2 ) / ( n1^2 - n2^2 )  ;

%Determine Colormap to use
val = get(h_pop_map,'Value');  
if val == 1
    eval('map=winter(num_max);');
elseif val ==2
    eval('map=spring(num_max);');
elseif val ==3
    eval('map=summer(num_max);');
elseif val ==4
    eval('map=autumn(num_max);');
elseif val ==5
    eval('map=jet(num_max);');
elseif val ==6
    eval('map=hsv(num_max);');
elseif val ==7
    eval('map=hot(num_max);');
end

%Normalized Dispersion Plot
set(gca,'ColorOrder',map,'NextPlot','replacechildren','box','on')
plot(V,b(:,:),'LineWidth',2);
grid on
title('Normalized dispersion graph b = f ( V )','FontSize',14)
xlabel('Normalized frequency V','FontSize',10)
ylabel('Normalized phase constant b','FontSize',10)
axis([min(V) max(V) 0 1])
colormap(map)
h_bar1 = colorbar('horiz') ;
mode_final = sprintf( 'TE.%d',num_max-1 );
set(h_bar1,'Xlim',[1 num_max+1],'XTick',[1 num_max+1],'XTickLabel',str2mat('TE.0' , mode_final))
set(get(h_bar1,'XLabel'),'String','Order of Modes Present From Lowest to Highest','FontSize',10)
