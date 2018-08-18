function sync2

%This Function Synchronizes the MonoChromatic and Dispersion Modules

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mode h_neff h_pguid h_pevan ...
    h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_wave h_pop_freq h_ndiff h_pop_map h_coffr h_cutsiz  h_modnum;

Co = 2.9979 * 10^8 ;

freq   = str2num( get( h_freq , 'String' ) );


%Define the unit-size of Frequency
freqval = get(h_pop_freq,'Value');
if freqval == 1
    freq = freq * 10^9;  %Giga Hertz
elseif freqval == 2
    freq = freq * 10^12; %Tera Hertz
elseif freqval == 3
    freq = freq * 10^15; %Peta Hertz
end

omega2 = str2num( get( h_o2 , 'String' ) );

n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));

%Define the unit-size of Guiding Layer Height
val = get(h_pop_h,'Value');
if val == 1
    h = h * 10^-3 ; %milli meters
elseif val == 2
    h = h * 10^-6 ; %micro meters
elseif val == 3
    h = h * 10^-9 ; %nano  meters
end

V = 2 * pi * freq * h * sqrt(n1^2 - n2^2) / (2 * Co);

if omega2 ~= freq * 2 * pi
    set(h_o2, 'String' , sprintf('%1.3g', freq * 2 * pi) );
    set(h_v2, 'String' , sprintf('%1.3g', V) );
end