function wavtofreq(i)

%This Function changes interactively the wavelength altered to frequency

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mode h_neff h_pguid h_pevan ...
    h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_wave h_pop_freq h_ndiff h_pop_map h_coffr h_cutsiz  h_modnum;

Co = 2.9979 * 10^8;

wave = str2num(get(h_wave,'String'));
freq = str2num(get(h_freq,'String'));

set(h_nom,'String',' ')
set(h_coffr,'String',' ')
set(h_neff,'String',' ')
set(h_pguid,'String',' ')
%set(h_pevan,'String',' ')
set(h_mode,'String',' ')
set(h_cutsiz,'String','[Hz]:')
set(h_modnum,'String','No Mode')


%Define the unit-size of Frequency
freqval = get(h_pop_freq,'Value');
if freqval == 1
    freq = freq * 10^9;  %Giga Hertz
elseif freqval == 2
    freq = freq * 10^12; %Tera Hertz
elseif freqval == 3
    freq = freq * 10^15; %Peta Hertz
end

%Define the unit-size of Wavelength
waveval = get(h_pop_wave,'Value');
if waveval == 1
    wave = wave * 10^-3 ;
elseif waveval == 2
    wave = wave * 10^-6 ;
elseif waveval == 3
    wave = wave * 10^-9 ;
end

%Compare the values & Assign the Frequency Unit Size
if freq ~= (Co / wave)
    if i ==1 % if i==1 then change freq
        freq = (Co/wave);
        if (freq > 10^9) & (freq < 10^12)
            set( h_freq , 'String' , sprintf('%3.3f',freq/10^9 ))
            set( h_pop_freq , 'Value' , 1 )
        elseif (freq > 10^12) & (freq < 10^15)
            set( h_freq , 'String' , sprintf('%3.3f',freq/10^12 ))
            set( h_pop_freq , 'Value' , 2 )
        elseif (freq > 10^15) & (freq < 10^18)
            set( h_freq , 'String' , sprintf('%3.3f',freq/10^15 ))
            set( h_pop_freq , 'Value' , 3 )
        else
            set( h_freq , 'String' , sprintf('%1.4g', freq ) )
            set( h_pop_freq , 'Value' , 4 )
        end
    elseif i==0 % if i==0 then change wave
        wave = (Co/freq);
        if (wave > 10^-3) & (wave < 10^0)
            set( h_wave , 'String' , sprintf('%3.3f',wave/10^-3 ))
            set( h_pop_wave , 'Value' , 1 )
        elseif (wave > 10^-6) & (wave < 10^-3)
            set( h_wave , 'String' , sprintf('%3.3f',wave/10^-6 ))
            set( h_pop_wave , 'Value' , 2 )
        elseif (wave > 10^-9) & (wave < 10^-6)
            set( h_wave , 'String' , sprintf('%3.3f',wave/10^-9 ))
            set( h_pop_wave , 'Value' , 3 )
        else
            set( h_wave , 'String' , sprintf('%1.4g', wave ) )
            set( h_pop_wave , 'Value' , 4 )
        end
    end
        
end