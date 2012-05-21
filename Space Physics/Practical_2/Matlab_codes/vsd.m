%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aim: 
% To compute 3D maxwellian velocity space distribution and calculate the
% solar wind protons number density.
%
% By: SHAHAB FATEMI	shahab@irf.se
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                % freeing up system memory
clc;                      % Clear Command Window

%% CONSTANT VALUES
unit_mass   = 1.6726E-27; % mass of a proton   [kg]
unit_charge = 1.6022E-19; % unit of charge     [C]

%% PARTICLES MASS
mass  = 1.0*unit_mass;    % mass of a particle

%% SOLAR WIND PARAMETERS
n_sw = 5.0E+6;   % number density [1/m^3]
T_sw = 1.0E+5;   % kinetic temperature [K]
U_sw = [0.0   0.0   0.0]; % Solar wind velocity [m/s]

%% VELOCITY SPACE DEFINITION
dv   = 10E+3;             % velocity step  [m/s]

v_x = -200E+3:dv:200E+3;
v_y = -200E+3:dv:200E+3;
v_z = -200E+3:dv:200E+3;

%% Pre-allocate memory for f(v)
f = zeros(length(v_x), length(v_y), length(v_z));

%% Compute f(v)
% Calculate f(v) for all 3 dimensions of the velocity
for i=1:length(v_x)
    i
    for j=1:length(v_y)
        for k=1:length(v_z)
            f(i,j,k) = maxwellian(mass, n_sw, T_sw, U_sw, [v_x(i) v_y(j) v_z(k)]);
        end
    end
end

%% Compute number density
n = sum(f(:))*(dv^3);

%% print the results on the screen
str_msg = sprintf('Initial solar wind density is: %E/m^3, Computed number density is: %E/m^3', n_sw, n);
disp(str_msg);
str_msg = sprintf('Computation error is: %E/m^3', n_sw-n);
disp(str_msg);





