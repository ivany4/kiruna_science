 clear all
clc
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
%--------------------------------------------------------------------------

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

%Plotting
figure
 subplot(3,1,1);
    plot(E4OB(:,1), ex,'b');
    xlabel('time[s]');
    ylabel('Ex[mV/m]');
    title('Electric Field Wave Measurements in OB System');
    
     subplot(3,1,2);
    plot(E4OB(:,1), ey,'r');
    xlabel('time[s]');
    ylabel('Ey[mV/m]');
    
    subplot(3,1,3);
    plot(E4OB(:,1), ez,'g');
    xlabel('time[s]');
    ylabel('Ez[mV/m]');
%--------------------------------------------------------------------------    

bx=B4OB(:,2).'; 
by=B4OB(:,3).'; 
bz=B4OB(:,4).'; 

%Plotting
figure
 subplot(3,1,1);
    plot(B4OB(:,1), bx,'b');
    xlabel('time[s]');
    ylabel('Bx[nT]');
    title('Magnetic Field Wave Measurements in OB System');
    
     subplot(3,1,2);
    plot(B4OB(:,1), by,'r');
    xlabel('time[s]');
    ylabel('By[nT]');
    
    subplot(3,1,3);
    plot(B4OB(:,1), bz,'g');
    xlabel('time[s]');
    ylabel('Bz[nT]');
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
 
 %-------------------------------------------------------------------------
%Computing Spectogram of Magnetic Field

%[vpsd,vpsdz,vpsddev,vkx,vky,vkz,vkxs,vkys,vkzs,vttags,vfreqs]= means(bx, by, bz, FSAMP, NK, Kstart, Kshift, N, NG, GW, ntshift, ntaver); 
[tfpsdB,  tfpsdEB,tfpsdBdev,vkx,vky,vkz,vkxs,vkys,vkzs,Bttags,tffreqsB]=means(bx, by, bz, 454.5, 11, 1, 512, 1024, 1024, 256, 256, 5);
figure
image( Bttags,tffreqsB,transpose(-log(tfpsdB)));