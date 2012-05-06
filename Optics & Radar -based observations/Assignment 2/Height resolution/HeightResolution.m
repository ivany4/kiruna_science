function HeightResolution(filename, repeat, plot_title)

%% structure of a file:
%  - UT
%  - Altitude
%  - Signal amplitude (linear)
%  - Signal-to-noise ratio (SNR), dB
%  - Zonal wind, m/s
%  - Meridional wind, m/s
%  - Vertical wind, m/s
%%
test_data = importdata(filename);
time = test_data(1:repeat:length(test_data), 1); %1st column in data
altitude = test_data(1:repeat, 2);               %2nd column in data

for i = 1:length(time);
    offset = (repeat * (i - 1)) + 1
    len = repeat
    SNR_alt = test_data(offset:offset+len-1, 4)  %1d array
    SNR(:, i) = SNR_alt;                         %2d matrix
end;

figure
pcolor(time, altitude, SNR)
shading flat
colormap jet
title(plot_title)
ylabel('Altitude [km]')
xlabel('Time [UT]')