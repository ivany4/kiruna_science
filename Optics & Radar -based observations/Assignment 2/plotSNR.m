function[fig] = plotSNR(data, repeat, plot_title, subplot_arg1, subplot_arg2, subplot_arg3)

%% structure of a data:
%  - UT
%  - Altitude
%  - Signal amplitude (linear)
%  - Signal-to-noise ratio (SNR), dB
%  - Zonal wind, m/s
%  - Meridional wind, m/s
%  - Vertical wind, m/s
%%
time = data(1:repeat:length(data), 1); %1st column in data
altitude = data(1:repeat, 2);               %2nd column in data

for i = 1:length(time);
    offset = (repeat * (i - 1)) + 1;
    len = repeat;
    SNR_alt = data(offset:offset+len-1, 4);  %1d array
    SNR(:, i) = SNR_alt;                         %2d matrix
end;

subplot(subplot_arg1, subplot_arg2, subplot_arg3);
fig = pcolor(time, altitude, SNR)
shading flat
colormap jet
title(plot_title)
ylabel('Altitude [km]')
xlabel('Time [UT]')

end