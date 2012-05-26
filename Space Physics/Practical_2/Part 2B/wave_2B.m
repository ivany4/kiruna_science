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


% figure
% plot(time_EFW,E_x_gse,'r')
% hold on
% plot(time_EFW,E_y_gse)
% xlabel('Time [Seconds]')
% ylabel('Electric Field [mV/m]')
% title('Variation of the Measured Components of the Electric Field (x_{GSE}, y_{GSE})')
% legend('E - x_{GSE}','E - y_{GSE}')
% hold off

time_FGM_STAFF = data.FGM_STAFF_t_gse_RS(:,1);

B_x_gse_fgm = data.FGM_STAFF_t_gse_RS(:,2);

B_y_gse_fgm = data.FGM_STAFF_t_gse_RS(:,3);

B_z_gse_fgm = data.FGM_STAFF_t_gse_RS(:,4);

% figure
% plot(time_FGM_STAFF,B_x_gse_fgm,'r')
% hold on
% plot(time_FGM_STAFF,B_y_gse_fgm,'b')
% plot(time_FGM_STAFF,B_z_gse_fgm,'g')
% xlabel('Time [Seconds]')
% ylabel('Magnetic Field [nT]')
% title('Variation of the Measured Components of the Magnetic Field (x_{GSE}, y_{GSE}, z_{GSE})')
% legend('B - x_{GSE}','B - y_{GSE}','B - z_{GSE}')
% hold off

B_x_gse_staff = data.FGM_STAFF_t_gse_RS(:,5);

B_y_gse_staff = data.FGM_STAFF_t_gse_RS(:,6);

B_z_gse_staff = data.FGM_STAFF_t_gse_RS(:,7);

% figure
% plot(time_FGM_STAFF,B_x_gse_staff,'r')
% hold on
% plot(time_FGM_STAFF,B_y_gse_staff,'b')
% plot(time_FGM_STAFF,B_z_gse_staff,'g')
% xlabel('Time [Seconds]')
% ylabel('Magnetic Field [nT]')
% title('Variation of the Measured Components of the Static Magnetic Field (x_{GSE}, y_{GSE}, z_{GSE})')
% legend('B - x_{GSE}','B - y_{GSE}','B - z_{GSE}')
% hold off

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
% 
% figure
% plot(time_FGM_STAFF, B_total)
% title('Total B field distribution')
% ylabel('B-field distribution [nT]')
% xlabel('Time [seconds]')
% grid on

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
 
%  [vpsd_E,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_E]= PSDvsFREQ(E_x_gse,E_y_gse,ez,25,11,1,512,2048,2048,512); 
 
[vpsd_E,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_E]= PSDvsFREQ(E_x_gse,E_y_gse,ez,25,11,1,128,128,128,32); 
 
 figure
 plot(vfreqs_E,log(vpsd_E));
%  errorbar(vfreqs_E, log(vpsd_E),vpsddev,'.-r', 'LineWidth', 1);
 title('PSD of the Electric Field');
 xlabel('Frequency [Hz]');
 ylabel('Spectral density');
 
 %% PSD of the Magnetic Field:
 
% [vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
% [vpsd_B,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_B]= PSDvsFREQ(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff,25,11,1,512,2048,2048,512);
 
[vpsd_B,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs_B]= PSDvsFREQ(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff,25,11,1,128,128,128,32);
 
figure
plot(vfreqs_B,log(vpsd_B));
% errorbar(vfreqs_B, log(vpsd_B), vpsddev,'.-r', 'LineWidth', 1);
 title('PSD of the Magnetic Field');
 xlabel('Frequency [Hz]');
 ylabel('Spectral density');
 
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

% [vpsd_E,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_E,vfreqs_E]=means(E_x_gse,E_y_gse,ez, 25, 16, 1, 128, 256, 256, 256, 256, 5);

% [vpsd_E,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_E,vfreqs_E]=means(E_x_gse,E_y_gse,ez, 25, 112, 1, 128, 1024, 1024, 256, 256, 5);
% 
% 
% figure
% imagesc(vttags_E,vfreqs_E,10*log10(vpsd_E'));
% colorbar
% axis('xy')
% title('Spectogram of the Electric Field');
% xlabel('Time');
% ylabel('Frequency');

% Spectogram of the Magnetic Field

%[vpsd,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags,vfreqs]= means(bx, by, bz, FSAMP, NK, Kstart, Kshift, N, NG, GW, ntshift, ntaver); 

% [vpsd_B,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_B,vfreqs_B]=means(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff, 25, 16, 1, 128, 256, 256, 256, 256, 5);
% 
% [vpsd_B,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags_B,vfreqs_B]=means(B_x_gse_staff,B_y_gse_staff,B_z_gse_staff, 25, 112, 1, 128, 1024, 1024, 256, 256, 5);
% 
% 
% figure
% imagesc(vttags_B,vfreqs_B,20*log10(vpsd_B'));
% colorbar
% axis('xy')
% title('Spectogram of the Magnetic Field');
% xlabel('Time');
% ylabel('Frequency');

