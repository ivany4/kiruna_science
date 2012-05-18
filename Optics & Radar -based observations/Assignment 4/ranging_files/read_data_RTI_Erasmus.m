%MIT IAP Radar Course 2011
%Resource: Build a Small Radar System Capable of Sensing Range, Doppler, 
%and Synthetic Aperture Radar Imaging 
%
%Gregory L. Charvat
% Edited for Erasmus Mundus Space Masters program
%  by P. J. Erickson  April 2012
%

%Process Range vs. Time Intensity (RTI) plot
close all;
clear all;

%read the raw data .wave file here
[Y,FS,NBITS] = wavread('running_outside_20ms.wav');

%constants
c = 3E8; %(m/s) speed of light

%radar parameters
Tp = 20E-3; %(s) pulse time
N = Tp*FS; %# of samples per pulse
fstart = 2260E6; %(Hz) LFM start frequency
fstop = 2590E6; %(Hz) LFM stop frequency

BW = fstop-fstart; %(Hz) transmit bandwidth
f = linspace(fstart, fstop, N/2); %instantaneous transmit frequency

%range resolution
rr = c/(2*BW);
max_range = rr*N/2;

%the input appears to be inverted
trig = -1*Y(:,1);
s = -1*Y(:,2);
clear Y;

%parse the data here by triggering off rising edge of sync pulse
count = 0;
thresh = 0;
start = (trig > thresh);
for ii = 100:(size(start,1)-N)
    if start(ii) == 1 & mean(start(ii-11:ii-1)) == 0
        count = count + 1;
        sif(count,:) = s(ii:ii+N-1);
        time(count) = ii*1/FS;
    end
end

%subtract the average
ave = mean(sif,1);
for ii = 1:size(sif,1);
    sif(ii,:) = sif(ii,:) - ave;
end

zpad = 8*N/2;

%RTI plot
v = dbv(ifft(sif,zpad,2));
S = v(:,1:size(v,2)/2);
m = max(max(S));
rng = linspace(0, max_range, zpad);

figure;
imagesc(rng,time,S-m,[-80, 0]);
colorbar;
ylabel('time (s)');
xlabel('range (m)');
title('RTI without clutter rejection');

%2 pulse canceller RTI plot
sif2 = sif(2:size(sif,1),:)-sif(1:size(sif,1)-1,:);
v2 = dbv(ifft(sif2,zpad,2));
S2 = v2(:,1:size(v2,2)/2);
m2 = max(max(S2));
R = linspace(0,max_range,zpad);


%2 pulse canceller RTI plot with third pulse subtracted from first
sif2 = sif(3:size(sif,1),:)-sif(1:size(sif,1)-2,:);
v2 = dbv(ifft(sif2,zpad,2));
S2 = v2(:,1:size(v2,2)/2);
m2 = max(max(S2));
R = linspace(0,max_range,zpad);

performance = (S2/m2)-(S(2:size(S,1),:)/m);

performance31 = (S2/m2)-(S(3:size(S,1),:)/m);

figure;
imagesc(R,time,S2-m2,[-80, 0]);
colorbar;
ylabel('time (s)');
xlabel('range (m)');
title('RTI with 2-pulse canceller clutter rejection');

figure;
imagesc(R,time,performance, [-0.5, 2.5]);
% plot(time, performance);
colorbar;
ylabel('Performance improvment [dB]');
xlabel('range (m)');
title('Performance improvement for clutter rejection');
