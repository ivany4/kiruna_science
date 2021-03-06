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
<<<<<<< HEAD

 
 %Transforming to Magenetic Field in OB System 
B4OB=OBsystem(b_wave ,b_FGM); 

%Computing the Third Electric Field
[e3comp]=thirdE(b_FGM,EFW_t_gse); 

%Transforming to Electric Field in OB System
E4OB=OBsystem(e3comp,b_FGM);

%Seperating the componenets in new OB system
ex=E4OB(:,2).'; % Transposing
ey=E4OB(:,3).'; 
ez=E4OB(:,4).'; 

bx=B4OB(:,2).'; 
by=B4OB(:,3).'; 
bz=B4OB(:,4).'; 

 %-------------------------------------------------------------------------
 %Computing PSD of Electric Field:
 %[vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [psdE,psddevE,psdEx,psdExdev,psdEy,psdEydev,psdEz,psdEzdev,Efreqs]= PSDvsFREQ(ex,ey,ez,454.5,11,1,512,2048,2048,512); 
 
 figure
 plot(Efreqs,log(psdE),'r');
 title('Electric Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');
 %-------------------------------------------------------------------------
 %Computing PSD of Electric Field:
 %[vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]=PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW) 
 
 [psdB,psddevB,psdBx,psdBxdev,psdBy,psdBydev,psdBz,psdBzdev,Bfreqs]= PSDvsFREQ(bx,by,bz,454.5,11,1,512,2048,2048,512); 
 
 figure
 plot(Bfreqs,log(psdB),'r');
 title('Magnetic Field Logarithimic PSD plot');
 xlabel('Frequency Distribution [hz]');
 ylabel('log[PSD]');

=======
>>>>>>> 7279d3aacbb1f8720128b6500fd1d8ff2a7c6343
