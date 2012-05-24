clear all;
close all;
clc;

load('E_B.mat');

%% CONSTANT VALUES
unit_mass   = 1.6726E-27;           % mass of a proton
unit_charge = 1.6022E-19;           % unit of a charge
e_mass = 9.109E-31;                 % mass of an electron

%% E-field

subplot(2,1,1);
plot(EFW_t_gse(:,1), EFW_t_gse(:,2), 'r', EFW_t_gse(:,1), EFW_t_gse(:,3), 'b');
legend('x_G_S_E','y_G_S_E')
title('EFW instrument measurements');
xlabel('Time [s]');
ylabel('Electric field [mV/m]');

%% B-field

subplot(2,1,2);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,2), 'r', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,3), 'b', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,4), 'g');
legend('x_G_S_E','y_G_S_E', 'z_G_S_E')
title('FGM instrument measurements (low frequency)');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');

figure;
title('STAFF instrument measurements (wave field)');
subplot(3,1,1);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,5), 'r'); 
legend('x_G_S_E');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');

subplot(3,1,2);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,6), 'b');
legend('y_G_S_E');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');

subplot(3,1,3);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,7), 'g');
legend('z_G_S_E');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');

%% Frequencies
N = size(FGM_STAFF_t_gse_RS, 1);

f_e = 0;
for i=1:N
    f_e = f_e + gyrofrequency([FGM_STAFF_t_gse_RS(i,2) FGM_STAFF_t_gse_RS(i,3) FGM_STAFF_t_gse_RS(i,4)]*10^-9, e_mass, -unit_charge);
end
f_e = f_e/N

f_p = 0;
for i=1:N
    f_p = f_p + gyrofrequency([FGM_STAFF_t_gse_RS(i,2) FGM_STAFF_t_gse_RS(i,3) FGM_STAFF_t_gse_RS(i,4)]*10^-9, unit_mass, unit_charge);
end
f_p = f_p/N

w_pe = plasma_frequency(1.5e6, -unit_charge, e_mass)

n = plasma_density(16e3, -unit_charge, e_mass)

% system('say "Underneath my skin theres an eagle" -v Alex');