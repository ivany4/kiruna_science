%%%     SPACE MASTER   %%%
%%%    Space Physics   %%%
%%%    Basyal,Rebelo   %%%
%%%     22/05/2012     %%%

clc

% Field Measurements

% Question 2: 

data = load('E_B.mat');

time_EFW = data.EFW_t_gse(:,1);

E_x_gse = data.EFW_t_gse(:,2);

E_y_gse = data.EFW_t_gse(:,3);

ez = zeros(22000,1);


figure
plot(time_EFW,E_x_gse,'r')
hold on
plot(time_EFW,E_y_gse)
xlabel('Time [Seconds]')
ylabel('Electric Field [mV/m]')
title('Variation of the Measured Components of the Electric Field (x_{GSE}, y_{GSE})')
legend('E - x_{GSE}','E - y_{GSE}')
hold off

time_FGM_STAFF = data.FGM_STAFF_t_gse_RS(:,1);

B_x_gse_fgm = data.FGM_STAFF_t_gse_RS(:,2);

B_y_gse_fgm = data.FGM_STAFF_t_gse_RS(:,3);

B_z_gse_fgm = data.FGM_STAFF_t_gse_RS(:,4);

figure
plot(time_FGM_STAFF,B_x_gse_fgm,'r')
hold on
plot(time_FGM_STAFF,B_y_gse_fgm,'b')
plot(time_FGM_STAFF,B_z_gse_fgm,'g')
xlabel('Time [Seconds]')
ylabel('Magnetic Field [nT]')
title('Variation of the Measured Components of the Magnetic Field (x_{GSE}, y_{GSE}, z_{GSE})')
legend('B - x_{GSE}','B - y_{GSE}','B - z_{GSE}')
hold off

B_x_gse_staff = data.FGM_STAFF_t_gse_RS(:,5);

B_y_gse_staff = data.FGM_STAFF_t_gse_RS(:,6);

B_z_gse_staff = data.FGM_STAFF_t_gse_RS(:,7);

figure
plot(time_FGM_STAFF,B_x_gse_staff,'r')
hold on
plot(time_FGM_STAFF,B_y_gse_staff,'b')
plot(time_FGM_STAFF,B_z_gse_staff,'g')
xlabel('Time [Seconds]')
ylabel('Magnetic Field [nT]')
title('Variation of the Measured Components of the Static Magnetic Field (x_{GSE}, y_{GSE}, z_{GSE})')
legend('B - x_{GSE}','B - y_{GSE}','B - z_{GSE}')
hold off

% Question 3:

% Theoretically found! Just seeing the plot!

% Question 4:

q = 1.6e-19;
mp = 1.67e-27;
me = 9.1e-31;
eps = 8.854e-12;
B_x2 = B_x_gse_fgm.*B_x_gse_fgm;
B_y2 = B_y_gse_fgm.*B_y_gse_fgm;
B_z2 = B_z_gse_fgm.*B_z_gse_fgm;
B_sum = B_x2 + B_y2 + B_z2;
B_total = sqrt(B_sum);

figure
plot(time_FGM_STAFF, B_total)
title('Total B field distribution')
ylabel('B-field distribution [nT]')
xlabel('Time [seconds]')
grid on

% Gyro Frequencies
gyro_freq_e_max = q * (max(B_total)*1e-12) / (2 * pi * me)
gyro_freq_e_min = q * (min(B_total)*1e-12) / (2 * pi * me)
gyro_freq_p_max = q * (max(B_total)*1e-12) / (2 * pi * mp)
gyro_freq_p_min = q * (min(B_total)*1e-12) / (2 * pi * mp)
ne = 4e6; 
freq_plasma = (sqrt((ne * (q^2)) / (me * eps))/(2*pi))

%estimated density from WHISPER data..
f_pe = 20E+3;
n_e = (f_pe/8980)^2
freq_plasma = (sqrt((4.9603 * (q^2)) / (me * eps))/(2*pi)) % CHECK!

% Question 5 & 6:
% 
% Inputs: 
% ex/bx, ey/by, ez/bz: three field components
% FSAMP: sampling frequency
% 
% NG, N, GW: fft-parameters,
% NG=length of record, 
% GW=length of centered Gaussian window,
% NG/N=number of frequency bins to average over;
% NK, Kstart, Kshift: Time-parameters, 
% NK=total number of time bins,
% Kstart=index where to start computation, 
% Kshift=number of points to shift between computations;
% 
% OUTPUT
% vpsd, vpsddev: Total power spectral density, standard deviation
% vpsdx, vpsdxdev: power spectral density in x-component, standard deviation
% vpsdy,vpsdz, vpsdydev, vpsdzdev: same for y- and z-components

%% PSD of the Electric Field:

% [vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(ex,ey,ez,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [vpsd_E,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_E]= PSDvsFREQ(E_x_gse,E_y_gse,ez,550,11,1,1024,2048,2048,512); 
 
 %[vpsd_E,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_E]= PSDvsFREQ(E_x_gse,E_y_gse,ez,450,169,1,128,128,128,32); 
 
 figure
 plot(vfreqs_E, log(vpsd_E));
 errorbar(vfreqs_E, log(vpsd_E), vpsddev, 'LineWidth', 2);
 title('PSD of the Electric Field');
 xlabel('Frequency [Hz]');
 ylabel('Logarithm of the Total Power Spectral density');
 
 %%% PSD of the Magnetic Field:
 
 % [vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [vpsd_B,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_B]= PSDvsFREQ(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff,550,11,1,2048,2048,2048,512);
 
 %[vpsd_B,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_B]= PSDvsFREQ(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff,25,169,1,128,128,128,32);
 
 figure
 plot(vfreqs_B,log(vpsd_B));
 errorbar(vfreqs_B, log(vpsd_B), vpsddev, 'LineWidth', 2);
 title('PSD of the Magnetic Field');
 xlabel('Frequency [Hz]');
 ylabel('Logarithm of the Total Power Spectral density');
 
% Question 7:

% INPUT 
% bx, by, bz: three field components
% FSAMP: sampling frequency
% 
% NG, N, GW: fft-parameters, 
% NG=length of record, 
% GW=length of centered Gaussian window, 
% NG/N=number of frequency bins to average over;
%
% ntshift, ntsvar: time-averaging parameters, 
% ntaver = number of fft-records to average over, 
% ntshift=number of points to shift for each new record;
%
% NK, Kstart, Kshift: global time-parameters, 
% NK=total number of time bins,
% Kstart=index where to start computation, 
% Kshift=number of points to shift for each new time bin;
%
% OUTPUT
% vpsd,vpsdz,vpsddev: Total power spectral density, PSD in the bz-component, standard 
% deviation in total PSD computation
%
% vkx,vky,vkz,vkxs,vkys,vkzs: The wave vector components and their standard
% deviations.

% Spectogram of the Electric Field

%[vpsd,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags,vfreqs]= means(bx, by, bz, FSAMP, NK, Kstart, Kshift, N, NG, GW, ntshift, ntaver); 

%[vpsd_E,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_E,vfreqs_E]=means(E_x_gse,E_y_gse,ez, 500, 156, 1, 128, 1024, 1024, 256, 256, 5);

[vpsd_E,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_E,vfreqs_E]=means(E_x_gse,E_y_gse,ez, 500, 16, 1, 8, 64, 64, 32, 16, 5);


figure
pcolor(vttags_E,vfreqs_E,20*log10(vpsd_E'));
colormap jet
shading flat
colorbar
title('Spectogram of the Electric Field');
xlabel('Time [Seconds]');
ylabel('Frequency [Hz]');

% Spectogram of the Magnetic Field

%[vpsd,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags,vfreqs]= means(bx, by, bz, FSAMP, NK, Kstart, Kshift, N, NG, GW, ntshift, ntaver); 

%[vpsd_B,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_B,vfreqs_B]=means(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff, 500, 156, 1, 128, 1024, 1024, 256, 256, 5);

[vpsd_B,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_B,vfreqs_B]=means(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff, 500, 16, 1, 8, 64, 64, 32, 16, 5);


figure
pcolor(vttags_B,vfreqs_B,20*log10(vpsd_B'));
colormap jet
shading flat
colorbar
title('Spectogram of the Magnetic Field');
xlabel('Time [Seconds]');
ylabel('Frequency [Hz]');

%% Question 8:

B_0 = [time_FGM_STAFF B_x_gse_fgm B_y_gse_fgm B_z_gse_fgm];

B_wave = [time_FGM_STAFF B_x_gse_staff B_y_gse_staff B_z_gse_staff];
B_wave_transf = OBsystem(B_wave, B_0);

E_wave = [time_EFW E_x_gse E_y_gse];
E_wave = thirdE(B_0, E_wave);
E_wave_transf = OBsystem(E_wave, B_0);

for i = 1:length(B_wave_transf)
    B_norm = sqrt(B_wave_transf(i,2)*B_wave_transf(i,2) + B_wave_transf(i,3)*B_wave_transf(i,3) + B_wave_transf(i,4)*B_wave_transf(i,4));
    B_wave_transf(i,:) = B_wave_transf(i,:)/B_norm;
end

for i = 1:length(E_wave_transf)
    E_norm = sqrt(E_wave_transf(i,2)*E_wave_transf(i,2) + E_wave_transf(i,3)*E_wave_transf(i,3) + E_wave_transf(i,4)*E_wave_transf(i,4));
    E_wave_transf(i,:) = E_wave_transf(i,:)/E_norm;
end

figure
plot(E_wave_transf(1,2),E_wave_transf(1,3),'o', 'color', 'r')
hold on
plot(E_wave_transf(1:10000,2),E_wave_transf(1:10000,3))
title('Hodogram of the Electric Field Wave Field Vector' );
xlabel('Normalized E_x');
ylabel('Normalized E_y');
xlim([-1 1])
ylim([-1 1])

figure
plot(B_wave_transf(1,2),B_wave_transf(1,3),'o', 'color', 'r')
hold on
plot(B_wave_transf(1:200,2),B_wave_transf(1:200,3))
title('Hodogram of the Magnetic Field Wave Field Vector' );
xlabel('Normalized B_x');
ylabel('Normalized B_y');
xlim([-1 1])
ylim([-1 1])