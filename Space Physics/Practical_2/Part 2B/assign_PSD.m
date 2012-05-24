clear all;
close all;
load('E_B.mat')

%--------------------------------------------------------------------------
% Wave Magnetic Field Components from STAFF instrument: 
b1_wave = FGM_STAFF_t_gse_RS(:,5);                 % B field component in X
b2_wave = FGM_STAFF_t_gse_RS(:,6);                 % B field component in Y
b3_wave = FGM_STAFF_t_gse_RS(:,7);                 % B field component in Z


%%
%  Computing PSD of Electric Field:
%[vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [psdB,psddevB,psdBx,psdBxdev,psdBy,psdBydev,psdBz,psdBzdev,Bfreqs]= PSDvsFREQ(b1_wave,b2_wave,b3_wave,454.5,11,1,512,2048,2048,512); 
 
 figure;
errorbar(Bfreqs, log10(psdB), log10(psddevB), 'Color', 'g');
hold;
  plot(Bfreqs,log(psdB),'r');  
 title('Electric Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');
 
 
 [psdB1,psddevB1,psdBx,psdBxdev,psdBy,psdBydev,psdBz,psdBzdev,Bfreqs]= PSDvsFREQ(b1_wave,b2_wave,b3_wave,454.5,1,1,512,256,256,512);
 
 figure;
errorbar(Bfreqs, log10(psdB1), log10(psddevB1), 'Color', 'b');
hold;
  plot(Bfreqs,log(psdB1),'r');

 title('Electric Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');
