clear all;
close all;

load('E_B.mat');

subplot(3,1,1);
plot(EFW_t_gse(:,1), EFW_t_gse(:,2), 'r', EFW_t_gse(:,1), EFW_t_gse(:,3), 'b');
legend('x_G_S_E','y_G_S_E')
title('EFW instrument measurements');
xlabel('Time [s]');
ylabel('Electric field [mV/m]');

subplot(3,1,2);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,2), 'r', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,3), 'b', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,4), 'g');
legend('x_G_S_E','y_G_S_E', 'z_G_S_E')
title('FGM instrument measurements (low frequency)');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');

subplot(3,1,3);
plot(FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,5), 'r', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,6), 'b', FGM_STAFF_t_gse_RS(:,1), FGM_STAFF_t_gse_RS(:,7), 'g');
legend('x_G_S_E','y_G_S_E', 'z_G_S_E')
title('STAFF instrument measurements (wave field)');
xlabel('Time [s]');
ylabel('Magnetic field [nT]');