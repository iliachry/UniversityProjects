function [T2,phi2]=uni(T,T1,phi)
%
Ts = union(T',T1','rows');
T2 = Ts';
phi2 = phi(:,T2);