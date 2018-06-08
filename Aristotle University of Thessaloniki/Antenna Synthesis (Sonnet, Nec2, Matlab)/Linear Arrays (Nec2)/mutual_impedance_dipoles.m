%Calculation of the mutual input impedance of 2 dipoles
%
%author: Ilias Chrysovergis
%date: March 2016

%parameters: r      = disc radius
%            l      = cone's wires length
%            2*theta0 = cone's apperture angle
%            d      = distance between the cone and the disc

function [ nec_file ] = mutual_impedance_dipoles()
    nec_file = fopen('mutual_impedance.nec','w');
    frequency = 3 * 10^9;
    c = 3 * 10^8 ; 
    wavelength = c/frequency;
    %fprintf(nec_file,'SY %.d 11 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',1,0,0,0,0,0,wavelength/2,wavelength/100);
    distance = 0.05*wavelength;
    fprintf(nec_file,'GW %.d 11 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',1,0,0,0,0,0,wavelength/2,wavelength/100);
    fprintf(nec_file,'GW %.d 11 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',2,distance,0,0,distance,0,wavelength/2,wavelength/100);  
    fprintf(nec_file,'GE -1\n');
    fprintf(nec_file,'GN -1\n');
    fprintf(nec_file,'EK');
    fprintf(nec_file,'EN');
    fclose('all');
end