clear all;
close all;

c = 3e8;
f = 233e6; %Default for EISCAT_3D
lambda = c/f;
d = 1.2876/4:1.2876/4:3;
theta = -pi/2:0.1*pi/180:pi/2;

%% Part 1
% Vary ratio between wavelength (lambda) and distance between individual elements (d)
% Keep number of antenna elements fixed

N = 64;

for i = 1:length(d)
    ratio = lambda/d(i);

    for j = 1:length(theta)
        Ea(i,j) = sin(N*pi*ratio*sin(theta(j)))/sin(pi*ratio*sin(theta(j)));
    end
    subplot(ceil(length(d)/3), 3, i);
    plot(theta,abs(Ea(i,:)/N));
    xlabel('Zenith angle \theta [rad]');
    ylabel('Field intensity E_a');
    title(['Ratio \lambda/d = ', num2str(ratio, 2)]);
end


input('Press any key to continue...');

%% Part 2
% Vary number of antenna elements

close all;

N = 2:12:64;
d = 1.2876/2;

for i = 1:length(N)
    ratio = lambda/d;   
    for j = 1:length(theta)
        Ea(i,j) = sin(N(i)*pi*ratio*sin(theta(j)))/sin(pi*ratio*sin(theta(j)));
    end
    subplot(ceil(length(N)/3), 3, i);
    plot(theta,abs(Ea(i,:)/N(i)));
    xlabel('Zenith angle \theta [rad]');
    ylabel('Field intensity E_a');
    title(['Number of elements N = ', int2str(N(i))]);
end

