clear all;
close all;
load('E_B.mat')

time = FGM_STAFF_t_gse_RS(:,1);
% Background Magnetic Field Components from FGM instrument: 
b1_FGM = FGM_STAFF_t_gse_RS(:,2);                 % B field component in X
b2_FGM = FGM_STAFF_t_gse_RS(:,3);                 % B field component in Y
b3_FGM = FGM_STAFF_t_gse_RS(:,4);                 % B field component in Z

b_FGM = [time, b1_FGM, b2_FGM, b3_FGM];
%--------------------------------------------------------------------------
% Wave Magnetic Field Components from STAFF instrument: 
b1_wave = FGM_STAFF_t_gse_RS(:,5);                 % B field component in X
b2_wave = FGM_STAFF_t_gse_RS(:,6);                 % B field component in Y
b3_wave = FGM_STAFF_t_gse_RS(:,7);                 % B field component in Z

b_wave = [time, b1_wave, b2_wave, b3_wave];

%%
%  Computing PSD of Electric Field:
%[vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [psdB,psddevB,psdBx,psdBxdev,psdBy,psdBydev,psdBz,psdBzdev,Bfreqs]= PSDvsFREQ(b1_wave,b2_wave,b3_wave,454.5,11,1,512,2048,2048,512); 
 
 figure;
 plot(Bfreqs,log(psdB),'r');
 title('Electric Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');
 
 
 [psdB1,psddevB,psdBx,psdBxdev,psdBy,psdBydev,psdBz,psdBzdev,Bfreqs]= PSDvsFREQ(b1_wave,b2_wave,b3_wave,454.5,1,1,512,256,256,512);
 
 figure;
 plot(Bfreqs,log(psdB1),'b');
%  hold;
%  errorbar(Bfreqs,log(psdB1),log(psdB1)-log(psdB));
 title('Electric Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');

 
