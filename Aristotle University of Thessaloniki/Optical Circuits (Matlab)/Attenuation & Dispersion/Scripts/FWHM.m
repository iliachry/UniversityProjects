function [ delta ] = FWHM( A_sq ,step )
%FWHM calculates the interval FWHM
    q=A_sq>=max(A_sq)/2;
    delta=(length(A_sq(q))-1)*step;
end

