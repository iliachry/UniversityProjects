function error_check

%This function does error checks for all inputs

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mis h_mode h_neff h_pguid h_err h_v1 h_v2 h_o1 h_o2;

%Take all the inputs from the edit-boxes
n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));
v1   = str2num(get(h_v1,'String'));
o1   = str2num(get(h_o1,'String'));
v2   = str2num(get(h_v2,'String'));
o2   = str2num(get(h_o2,'String'));
wave = str2num(get(h_wave,'String'));
freq = str2num(get(h_freq,'String'));
num  = str2num(get(h_mode,'String'));

err_check = [ n1 n2 h o1 o2 v1 v2 wave freq num ];

%Error Check -> If the expressions are NaNs & not real
nan_check = isnan(err_check);
if any(nan_check == 1) | any(~isreal(err_check))
    set(h_err,'String',errstr1)
    error(errstr1)
end

%Error Check -> Negative inputs
errstr2 = 'Invalid input(s) => Negative number(s)';
if any(err_check < 0)
   set(h_err,'String',errstr2)
   error(errstr2)
end

%Error Check -> Concerning n2 > n1
if n2>=n1
    set(h_err,'String','Radiation Modes Developed => Please ensure that n1 > n2')
    error('Radiation Modes Developed => Please ensure that n1 > n2')
end

%If no error occured
set(h_err,'String','None So Far')