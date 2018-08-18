function [ beta , n_eff , mod_num ] = disper( omega , h , n1 , n2 )

global h_n1 h_n2 h_h h_wave h_freq h_cnom h_nom h_mis h_mode h_neff h_pguid h_err;
global V;

%Dispersion on a Planar Dielectric Waveguide
%
%Calculates the phase constant and effective refractive indices of all
%guided TE-modes at frequency omega given the characteristics of the
%waveguide h,n1,n2 :
%
%   [ beta , n_eff , mod_num ] = disper( omega , h , n1 , n2 )
%
%   Input  : n1,n2  --> Refractive Indices of guiding layer (n1) and of substrate/cladding (n2)
%            h      --> Height of guiding layer (h) in metres
%            omega  --> Angular frequency (omega) in radians per second <==> wavelength (lamda) in metres
%   
%   Output : beta   --> Phase constants (beta) of all guided modes on each frequency/wavelength
%            n_eff  --> Effective Refractive Indices (n_eff) of the above modes
%            mod_num--> Maximum number of modes detected (at the highest frequnecy of the range specified)
%  --------> This version of disper never misses modes , it just gets stuck    

warning off MATLAB:divideByZero
format long

%Speed of light in free-space (Co) in metres per second
Co = 2.9979 * 10^8 ;

%Normalized parameters
V = omega * h * sqrt(n1^2 - n2^2) / (2 * Co) ;

%NumberOfModes expected to develop at each frequency(each V)
NoM = floor(2*V/pi) + 1;

%Check if any of the input frequencies causes a NoM > 600 before disper goes into the for loop and crashes if that the case 
if any( NoM>600 )
    set(h_err,'String','Number of Modes Exceeds 600 => Algorithm Unsuccesful')
    error('Number Of Modes exceeds 600 => Algorithm Unsuccesful')
end

for j = 1:length(V)
    %Calculate the infinities of the tan(...) part of the Characteristic Equation
    for k=0:NoM(j)-1;
        b_inf_tan(k+1) = 1 - (  ( (2*k+1) * pi )/ ( 4 * V(j) )    )^2 ;
    end
    
    %If the above array has NoM-1 elements between [0,1] the add 0. 
    if b_inf_tan( NoM(j) )<0
        b_inf_tan( NoM(j) ) = 0;
    end
    
    %Add the infinity of the .../(1-2*b) part of the Characteristic Equation, at b=0.5
    b_inf_tan( NoM(j)+1 ) = 0.5;
    
    %Sort these infinities in ascending order -----> We know that the roots (NoM in number) of
    %the Characteristic Equation are between these infinities (NoM + 1 in number)
    b_infs = sort(b_inf_tan);
    
    %Call the fzero function to compute these roots, given the sign-change
    %limits or the range. upstep/downstep are the steps up/down the inf
    %values. Typically upstep/downstep = eps (very small) for high freq and
    %upstep=0 and downstep=0.1 for low freq (V<10^-7)
    if V(j) < 10^-3;
        upstep   = 0;
        downstep = 0.01;
    else
        upstep   = 3*eps;
        downstep = 3*eps;
    end
    
    for i=1:NoM(j)
        b_roots(j,i) = fzero(@equation,[b_infs(i)+upstep b_infs(i+1)-downstep]);
    end
end

%Re-arrange the b_roots array so that each row starts with the TE-0 mode roots
%and moves on to the higher mode roots
b_roots = -sort(-b_roots,2);

%Number of Roots found at the maximum frequency/wavelength/V of the range
%specified == max(NoM) for this algorithm. Modes Missed == 0
mod_num = size(b_roots,2);

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
