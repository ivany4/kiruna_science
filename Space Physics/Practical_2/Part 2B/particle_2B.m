%%Spectrogram

close all; 
clear all;

fid = fopen('orb_1069_swim.csv');
A = textscan(fid, '%*11c %2d %*1c %2d %*1c %2d %*4s  %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'commentStyle', '#', 'CollectOutput', 1);
fclose(fid);

t = A{1};
data_1069 = A{2};
hh = t(:,1);
t_index = 1:length(hh);

energy_levels=[106;132;165;206;258;322;403;503;629;786;983;1229;1536;1920;2400;3000];
figure
image(energy_levels,t_index,data_1069);
title('Spectrogram for orbit 1069')
xlabel('Energy level [eV]')
ylabel('Time')

fid = fopen('orb_1070_swim.csv');
B = textscan(fid, '%*11c %2d %*1c %2d %*1c %2d %*4s  %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'commentStyle', '#', 'CollectOutput', 1);
fclose(fid);

t = B{1};
data_1070 = B{2};
hh = t(:,1);
t_index = 1:length(hh);
energy_levels=[106;132;165;206;258;322;403;503;629;786;983;1229;1536;1920;2400;3000];
figure
image(energy_levels,t_index,data_1070);
title('Spectrogram for orbit 1070')
xlabel('Energy level [eV]')
ylabel('Time')
%% Energy Spectra

energy1069 = data_1069(75:400,:);
energy1070 = data_1070(25:300,:);

Counts_1069 = (sum(energy1069));
Counts_1070 = (sum(energy1070));

figure
plot(energy_levels,Counts_1069,'r');
title('Energy Spectrum for 1069 orbit');
ylabel('Counts')
xlabel('Energy levels')

figure
plot(energy_levels,Counts_1070,'r');
title('Energy Spectrum for 1070 orbit');
ylabel('Counts')
xlabel('Energy level')
%% Tranformation to Velocity Space

e = 1.602e-19; % Fundamental unit charge
mp = 1.673e-27; % Mass of an proton

energy_levels_Joule = energy_levels*e;

velocity_levels = sqrt((2*energy_levels_Joule)/mp);

figure
plot(velocity_levels,Counts_1069,'r--');
title('Velocity Spectrum for 1069 orbit');
ylabel('Counts')
xlabel('Velocity [m/s]')

figure
plot(velocity_levels,Counts_1070,'r--');
title('Velocity Spectrum for 1070 orbit');
ylabel('Counts')
xlabel('Velocity [m/s]')