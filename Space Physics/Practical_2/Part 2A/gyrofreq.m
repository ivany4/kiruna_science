%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function name:    gyrofreq
% 
% Parameters:
%            q:  electric charge  [C]
%         mass:  particle's mass  [kg]
%      B_field:  magnetic field   [T]
%
% return value:
%    gyrofrequency: \omega = q B_field/mass
%
% By: SHAHAB FATEMI	shahab@irf.se
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function g = gyrofreq(q, mass, B_field)
    g = q*norm(B_field)/mass;
end
