function plotSNR(data, repeat, plot_title, subplots)

time = data(1:repeat:length(data), 1); %1st column in data
altitude = data(1:repeat, 2);               %2nd column in data

for i = 1:length(time);
    offset = (repeat * (i - 1)) + 1;
    len = repeat;
    SNR_alt = data(offset:offset+len-1, 4);  %1d array
    SNR(:, i) = SNR_alt;                         %2d matrix
end;

fig = figure(1000);
axes = findall(fig,'type','axes');
num = length(axes);
subplot(1, subplots, num+1);
pcolor(time, altitude, SNR);
shading flat
colormap jet
ylabel('Altitude [km]')
xlabel('Time [UT]')
title(plot_title)
axes = findall(fig,'type','axes');
num = length(axes);

if num == subplots
    color = colorbar;   %Insert colorbar
    set(color, 'Position', [.924 .11 .0381 .8150])
    for i = 1:num       %Narrow diagrams
        pos = get(axes(i), 'Position');
        set(axes(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end;
end

end