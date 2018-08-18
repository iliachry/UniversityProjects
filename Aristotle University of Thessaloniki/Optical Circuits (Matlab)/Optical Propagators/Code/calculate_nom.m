function calculate_nom

%This function, called with no input (but with global variables and
%variable handles) estimates the number of modes to develop at a specific
%wavelengt/frequency/V number and the number of modes missed

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mode h_neff h_pguid h_pevan h_err h_pop_wave h_pop_h ...
    h_coffr h_modnum h_cutsiz;

Co = 2.9979 * 10^8 ;

%Take the Structural and the MonoChromatic Response parameters from the
%edit-boxes
n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));
wave = str2num(get(h_wave,'String'));

%Error Check -> Case of empty matrix result
err = [ n1 n2 h wave ];
if length(err) ~=4
    set(h_err,'String','Invalid Input(s) => Please Correct Expression')
    error('String','Invalid Input(s) => Please Correct Expression')
end

%Define the unit-size of Wavelength
val = get(h_pop_wave,'Value');
if val == 1
    wave = wave * 10^-3 ;
elseif val == 2
    wave = wave * 10^-6 ;
elseif val == 3
    wave = wave * 10^-9 ;
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

omega = 2 * pi * Co / wave;
V = omega * h * sqrt(n1^2 - n2^2) / (2*Co); 
num_max = floor(2*V/pi) + 1;

%Give data (NoM, Missed etc) back to the edit-boxes of the GUI
set(h_nom,'String',num2str(num_max))
set(h_coffr,'String',' ')
set(h_neff,'String',' ')
set(h_pguid,'String',' ')
%set(h_pevan,'String',' ')
set(h_mode,'String',' ')
set(h_cutsiz,'String','[Hz]:')
set(h_modnum,'String','No Mode')

%Profile Parameters when no mode is requested for plot
% x1 = linspace( 0  , h   , 1000);
% x2 = linspace( -h , 0   , 100);
% x3 = linspace( h  , 2*h , 100);
% fill([0 h h 0],[-1 -1 1 1],[0.85 0.85 0.85]);
% hold on
% plot([0,0],-1:2:1,'k',[h,h],-1:2:1,'k','LineWidth',4)
% hold on
% plot([h/2,h/2],-1:2:1,'k-.',-h:3*h:2*h, [0,0],'k-.','LineWidth',2)
% hold on
% axis([-h 2*h -1 1])
% grid on
% set(gca,'Layer','Top')
% hold off

%NumberOfModes Error Check for protection
if num_max > 600
    set(h_err,'String','Too many modes develloped ==> Algorithm Unsuccesful')
    disp('Number of modes develloped :')
    disp(num_max)
    error('>>>>>Too many modes develloped ==> EXTREMELY LONG processing time<<<<<<')
end
