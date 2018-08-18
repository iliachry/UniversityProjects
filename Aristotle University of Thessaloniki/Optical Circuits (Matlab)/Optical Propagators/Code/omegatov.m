function omegatov

%This function changes the vs correspondingly whenever one of the omega's
%is altered

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mode h_neff h_pguid h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_wave h_freq_size;

Co = 2.9979 * 10^8;

n1 = str2num(get(h_n1,'String'));
n2 = str2num(get(h_n2,'String'));
h  = str2num(get(h_h ,'String'));
v1 = str2num(get(h_v1,'String'));
o1 = str2num(get(h_o1,'String'));
v2 = str2num(get(h_v2,'String'));
o2 = str2num(get(h_o2,'String'));

%Define the unit-size of Guiding Layer Height
val = get(h_pop_h,'Value');
if val == 1
    h = h * 10^-3 ; %milli meters
elseif val == 2
    h = h * 10^-6 ; %micro meters
elseif val == 3
    h = h * 10^-9 ; %nano  meters
end


aux= h*sqrt(n1^2 - n2^2)/(2*Co);

%Chenge v2 if o2 is altered
if v2 ~= (o2 * aux)
    set( h_v2 , 'String' , sprintf('%1.3g',o2*aux) )
end

%Change v1 if o1 is altered
if v1 ~= (o1 * aux)
    set( h_v1 , 'String' , sprintf('%1.3g',o1*aux) )
end