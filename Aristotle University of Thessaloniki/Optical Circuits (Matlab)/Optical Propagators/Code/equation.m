function ToSolve = equation(b)
%Characteristic Equation of the TE-Modes in a Planar Dielectic Waveguide

global V;

ToSolve = tan( 2 * V * sqrt(1-b) ) - ones(size(V))*( 2 * sqrt(b - b.^2) ./ (1 - 2*b) );