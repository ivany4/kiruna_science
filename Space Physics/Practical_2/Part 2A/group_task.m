clear all;
close all;
clc;

load('group02.mat');

%% CONSTANT VALUES
unit_mass   = 1.6726E-27;           % mass of a proton
unit_charge = 1.6022E-19;           % unit of a charge
k_b = 1.38065E-23;

%%
%---------------------------------------------
% Given numbers:
vmin = -8e5;
vmax = 8e5;
dv = 5e3;
B_sw = [0.0    5e-9    0.0];  % Interplanetary Magnetic Field (IMF)
% U_sw = [-1     0.0     0.0];  % Solar Wind in -x axis
m = 1.0*unit_mass;
% f

%---------------------------------------------
% Bin the velocity space:
v_x = vmin : dv : vmax;
v_y = vmin : dv : vmax;
v_z = vmin : dv : vmax;

%% Compute number density
n = sum(f(:))*(dv^3)

%% Compute flux

[Gamma_x Gamma_y Gamma_z] = flux(v_x, v_y, v_z, dv, f)

u_sw = [Gamma_x/n Gamma_y/n Gamma_z/n]

%% Plots
figure
subplot(1,2,1)
contour(v_x,v_y,f(:,:,161))
xlabel('V_y [m/s]')
ylabel('V_x [m/s]')
title('Contour map of the distribution function in V_x-V_y plane')
grid on
subplot(1,2,2)
x = f(161,:,:);
x = reshape(x,321,321);
contour(v_y,v_z,x);
xlabel('V_z [m/s]')
ylabel('V_y [m/s]')
title('Contour map of the distribution function in V_y-V_z plane')
grid on
figure
x=f(:,161,:);
x = reshape(x,321,321);
contour(v_x,v_z,x)
xlabel('V_z [m/s]')
ylabel('V_x [m/s]')
title('Contour map of the distribution function in V_y-V_z plane')
grid on

%% Pressure Tensor
p_s = pressure_tensor(v_x, v_y, v_z, dv, f, u_sw, m)
scalar_p_s = trace(p_s)/3.0

%% Thermal Velocity
T = p_s /(n*k_b)
v_th = sqrt(2*k_b*T/m)


system('say "Matlab is ready"');