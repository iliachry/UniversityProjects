function [ beta , n_eff , mod_num , missed ] = disper0( omega , h , n1 , n2 )

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mis h_mode h_neff h_pguid h_err;

%Dispersion on a Planar Dielectric Waveguide
%
%Calculates the phase constant and effective refractive indices of all
%guided TE-modes at frequency omega given the characteristics of the
%waveguide h,n1,n2 :
%
%   [ beta , n_eff , mod_num , missed ] = disper( omega , h , n1 , n2 )
%
%   Input  : n1,n2  --> Refractive Indices of guiding layer (n1) and of substrate/cladding (n2)
%            h      --> Height of guiding layer (h) in metres
%            omega  --> Angular frequency (omega) in radians per second <==> wavelength (lamda) in metres
%   
%   Output : beta   --> Phase constants (beta) of all guided modes on each frequency/wavelength
%            n_eff  --> Effective Refractive Indices (n_eff) of the above modes
%            mod_num--> Maximum number of modes detected (at the highest frequnecy of the range specified)
%            missed --> Maximum Number of modes missed by the scan routine 

warning off MATLAB:divideByZero

%Speed of light in free-space (Co) in metres per second
Co = 2.9979 * 10^8 ;

if n2 >= n1
    error('Symmetrical Planar Definition Violation , Please ensure that n1 > n2')
end

%Normalized parameters
V = omega' * h * sqrt(n1^2 - n2^2) / (2 * Co) ; 
b = (0:0.00005:1) ;

%Number of modes expected to appear --> relavant to V_over_(pi/2) ratio
number_of_modes = floor( 2 * V / pi) + 1 ;

%Algorithm functionality threshold & Overflow Protection
if any( number_of_modes > length(b) )
    disp('Number of modes develloped :')
    disp(max(number_of_modes))
    set(h_err,'String','Be more logical, will you? ;-) ')
    msgbox('The number of modes develloped is RIDICULOUS for this application to process','Are You Serious?','error')
    error('The number of modes develloped is RIDICULOUSLY vast for this application to process')
elseif any( number_of_modes > 500 )
    disp('Number of modes develloped :')
    disp(max(number_of_modes))
    set(h_err,'String','Number Of Modes exceeds 500')
    msgbox('EXTREMELY long processing time' ,'I just CAN''T do it...','error')
    error('EXTREMELY LONG PROCESSING TIME')
elseif any( number_of_modes > 99 )
    disp('Number of modes develloped :')
    disp(max(number_of_modes))
    set(h_err,'String','Algorithm Functionality Threshold Breached => Results Corrupted !!')
    disp('Too many modes develloped ==> Certain modes may not be detected !! ==> Results might be corrupted !!' )
end

%Characteristic Equation of BOTH even & odd modes
Ch_Eq = tan( 2 * V * sqrt(1-b) ) - ones(size(V))*( 2 * sqrt(b - b.^2) ./ (1 - 2*b) );

%Differential of Ch_Eq (DE) used with sign-change function to distinguish [-inf, +inf] from zero-cross sign change
DE = diff(Ch_Eq,1,2); %==> So that the differention is done between columns (along the dimension of [b]s)

%Relative Representation of infinity
DiffMax = sort(DE,2); %Sorting the values of the difference from smallest to highest. The highest ones are cause by the [-inf -> +inf] transition caused by the tangeant near k*pi/2 , k natural
infinity = 0.5*(DiffMax( length(b) - 1 - max(number_of_modes) ) + DiffMax( length(b) - 2 -max(number_of_modes)) ); %We set infi right between the smallest [-inf->+inf] differential and the largest non-singular differential
infi  = abs(infinity);

%Scan the Ch_Eq = f(b) values for possible roots between b=[0..1] => n_effective=[n2..n1]
for k=length(V):-1:1 % Scan LINES => Take the [omega/lamda/V] one-by-one - Start from max[V] because the number of modes developed increases with frequency
    rc = 0; %Ch_Eq(b) Root Counter for each [omega/lamda/V] (each line)
    if omega(k) == 0 %At DC (f=0) the TE-0 mode is the only one present and is infinitely above cut-off => n_eff = n2 => b = 0
        rc = rc + 1;
        b_roots(k,rc) = 0;
        continue
    end
    for i=1:( length(b) -1 ); % Scan COLUMNS => Take for each [V] the [b]s one-by-one  - Start from min[b] = n2 (closest to cut-off)
        sgn = sign( Ch_Eq(k,i+1) ) * sign( Ch_Eq(k,i) );
        if ( Ch_Eq(k,i) == 0 ) %By pure chance we fell right on a root - highly improbable!!!
            rc = rc + 1;
            b_roots(k,rc) = b(i);
            continue
        else
            if ( sgn == -1 )&( DE(k,i) < infi ) %Sign-changes between this and the next [b] AND difference between the two is not infinite
                zero = b(i) - Ch_Eq(k,i) * ( b(i+1) - b(i) ) / ( Ch_Eq(k,i+1) - Ch_Eq(k,i) ); %Linear Interpolation for more accuracy on the root
                rc = rc + 1;
                b_roots(k,rc) = zero;
                continue
            else
                if ( sgn == 0 )&( i == ( length(b) - 1 ) )&( rc < number_of_modes(k) ) %ONLY on very high freq (many modes)==> TE-0 mode near threshold (Approx) => b=1 => n_eff(TE0) = n1 
                    zero = b(i) - Ch_Eq(k,i) * ( b(i+1) - b(i) ) / ( Ch_Eq(k,i+1) - Ch_Eq(k,i) ); %Linear Interpolation for more accuracy on the root
                    rc = rc + 1;
                    b_roots(k,rc) = zero;
                    continue
                end
            end
        end
    end
end

%On very high frequencies (=> many modes) some modes are not detected by the routine so
%size(b_roots,2) =< max(number_of_modes)
for i=1:length(V)
    modes_missed(i) = number_of_modes(i) - size(b_roots,2); %Modes missed by algorithm at each frequency/wavelength step
end
mod_num = size(b_roots,2);
missed  = max(modes_missed);

%Rearrange the b_roots array so that each row starts with the lowest order mode present , that means TE-0 -> TE-x .
%It is presumed that the lowest the mode the highest the b_root/beta/n_eff
b_roots = -sort(-b_roots,2);

%Effective refractive indices of all guided modes:
%Columns : Left->Right : Lowest->Highest order mode present (lowest mode: TE-0 present at ALL freqeuncies) - All else Nan
%Row     : Top->Bottom : First->Last input frequency
for i=1:length(V) ;
    for j=1:size(b_roots,2)
        if xor ( ( b_roots(i,j) == 0 ),( (omega(i)==0)&(j==1) ) ) %The last two conditions distinguish the b=0 DC-root from the b=0 that fill the b_roots matrix when it is extended beyond one mode(one column)
            n_eff(i,j) = NaN;
        else 
            n_eff(i,j) = sqrt( (n1^2 - n2^2) * b_roots(i,j) + n2^2 );
        end
    end
end

%Phase constants (beta) in radians per metre
%Same arrengment as the effective refractive indices
for i=1:length(V)
    for j=1:size(b_roots,2)
        beta(i,j) = n_eff(i,j) * omega(i) / Co ;
    end
end
