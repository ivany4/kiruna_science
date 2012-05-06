function plotWind(data, repeat, coding_type, date)

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
altitude = data(1:repeat, 2);

loop = 1;
cnt = 1;
for i = 1:length(data);
    zonal_wind = data(i, 5); 
    meridional_wind = data(i, 6);
    horizontal_wind(loop, cnt) = hypotenuse(zonal_wind, meridional_wind);
    wind_direction(loop, cnt) = radToDeg(atan((meridional_wind)/(zonal_wind)));
    loop = loop + 1;
    if loop > repeat
        loop = 1;
        cnt = cnt + 1;
    end;
end;

figure
pcolor(time, altitude, horizontal_wind)
shading flat
colormap jet
title(['Horizontal Wind Velocity [m/s] with ', coding_type, ' data (', date, ')'])
ylabel('Altitude [km]')
xlabel('Time [UT]')
colorbar('location', 'EastOutside')

figure
pcolor(time, altitude, wind_direction)
shading flat
colormap jet
title(['Horizontal Wind Direction [deg] with ', coding_type, ' data (', date, ')'])
ylabel('Altitude [km]')
xlabel('Time [UT]')
colorbar('location', 'EastOutside')

end

