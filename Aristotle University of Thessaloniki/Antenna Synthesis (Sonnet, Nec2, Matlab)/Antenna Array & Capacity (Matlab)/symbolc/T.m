function [ T_symbolic ] = T( N )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

syms z T_symbolic;

if N ==0
    T_symbolic = 1;
elseif N==1
    T_symbolic = z;
else
    T_symbolic = 2*z*T(N-1) - T(N-2);
end

end

