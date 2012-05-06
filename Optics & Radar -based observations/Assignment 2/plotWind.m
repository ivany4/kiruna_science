function plotWind(data, repeat, coding_type, date, subplots)

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


fig = figure(1001);
axes = findall(fig,'type','axes');
num = length(axes);
subplot(1, subplots, num+1);
pcolor(time, altitude, horizontal_wind)
shading flat
colormap jet
ylabel('Altitude [km]')
xlabel('Time [UT]')
title([coding_type, ' data'])
axes = findall(fig,'type','axes');
num = length(axes);

if num == subplots
    set(fig, 'Name', ['Horizontal Wind Velocity [m/s] (', date, ')']);  %set figure title
    color = colorbar;   %Insert colorbar
    set(color, 'Position', [.924 .11 .0381 .8150])
    for i = 1:num       %Narrow diagrams
        pos = get(axes(i), 'Position');
        set(axes(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end;
end

fig = figure(1002);
axes = findall(fig,'type','axes');
num = length(axes);
subplot(1, subplots, num+1);
pcolor(time, altitude, wind_direction)
shading flat
colormap jet
ylabel('Altitude [km]')
xlabel('Time [UT]')
title([coding_type, ' data'])
axes = findall(fig,'type','axes');
num = length(axes);

if num == subplots
    set(fig, 'Name', ['Horizontal Wind Direction [deg] (', date, ')']);  %set figure title
    color = colorbar;   %Insert colorbar
    set(color, 'Position', [.924 .11 .0381 .8150])
    for i = 1:num       %Narrow diagrams
        pos = get(axes(i), 'Position');
        set(axes(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end;
end


end

