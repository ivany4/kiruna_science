levels=[106;132;165;206;258;322;403;503;629;786;983;1229;1536;1920;2400;3000];
fid = fopen('orb_1069_swim.csv');
C = textscan(fid, '%*17c %f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'commentStyle', '#', 'CollectOutput', 1);
fclose(fid);
data=C{1};
time=data(:,1);

n=0;
for i=2:length(time);
    timesec(i)=time(i)+ (n*60);
    if(time(i)<time(i-1))
        n=n+1;
    end
end

for i=1:length(time);
    timemin(i)=timesec(i)/60;
end

energy=data(:,2:17);
figure
image(timemin,levels,energy')
axis('xy')
title('Spectrogram for orbit 1069')
ylabel('Energy level [eV]')
xlabel('Time [min]')


fid = fopen('orb_1070_swim.csv');
C = textscan(fid, '%*17c %f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'commentStyle', '#', 'CollectOutput', 1);
fclose(fid);
data2=C{1};
time2=data2(:,1);

n=0;
for i=2:length(time2);
    timesec2(i)=time2(i)+ (n*60);
    if(time2(i)<time2(i-1))
        n=n+1;
    end
end

for i=1:length(time2);
    timemin2(i)=timesec2(i)/60;
end

energy2=data2(:,2:17);
figure
image(timemin2,levels,energy2')
axis('xy')
title('Spectrogram for orbit 1070')
ylabel('Energy level [eV]')
xlabel('Time [min]')

%%
%Question 3

energysel1 = energy(189:263,:);
energysel2 = energy2(31:58,:);
energyadd1=(sum(energysel1))/74;
energyadd2=(sum(energysel2))/27;

figure
plot(levels,energyadd1,'-o')
title('Energy Spectra of Orbit 1069 from minute 25 to 35 in orbit')
ylabel('Counts')
xlabel('Energy level [eV]')
figure
plot(levels,energyadd2,'-o')
title('Energy Spectra of Orbit 1070 from minute 10 to 20 in orbit')
ylabel('Counts')
xlabel('Energy level [eV]')

%%
%Question 4

%Transformation from energy space to velocity space

energyjoules1=levels*(1.602e-19);
energyjoules2=levels*(1.602e-19);
velocity1=sqrt((energyjoules1*2)/(1.673e-27));
velocity2=sqrt((energyjoules2*2)/(1.673e-27));

figure
plot(velocity1,energyadd1,'o')
title('Velocity space of Orbit 1069 from minute 25 to 35 in orbit')
ylabel('Counts')
xlabel('Velocity [m/s]')
hold on
figure
plot(velocity2,energyadd2,'o')
title('Velocity space of Orbit 1070 from minute 10 to 20 in orbit')
ylabel('Counts')
xlabel('Velocity [m/s]')
hold on

z=abs(lsqcurvefit(@maxwellian,[.01,.1000,.300000],levels,velocity1));
xdata=0:1:3000;
plot(xdata,maxwellian(z,xdata));
z2=abs(lsqcurvefit(@maxwellian,[.01,.1000,.300000],levels,velocity2));
plot(xdata,maxwellian(z2,xdata));