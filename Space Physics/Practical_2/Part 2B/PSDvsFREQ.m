% PSDvsFREQ: Computing PSD versus frqeuency with standard deviation
% Written by Gabriella Stenberg from Tord Oscarsson's FORTRAN-version 
% Last changed: 2008-03-19, 15:48 UT
%
%
% INPUT 
% bx, by, bz: three field components
% FSAMP: sampling frequency
% 
% NG, N, GW: fft-parameters, NG=length of record, GW=length of centered
% Gaussian window, NG/N=number of frequency bins to average over;
%
% NK, Kstart, Kshift: Time-parameters, NK=total number of time bins,
% Kstart=index where to start computation, Kshift=number of points to
% shift between computations;
%
% OUTPUT
% vpsd, vpsddev: Total power spectral density, standard deviation
% vpsdx, vpsdxdev: power spectral density in x-component, standard
% deviation
% vpsdy,vpsdz, vpsdydev, vpsdzdev: same for y- and z-components
%
%

function [vpsd,vpsddev,vpsdx,vpsdxdev,vpsdy,vpsdydev,vpsdz,vpsdzdev,vfreqs]= ...
    PSDvsFREQ(bx,by,bz,FSAMP,NK,Kstart,Kshift,N,NG,GW)


%%% INITIALIZING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 10, GW=32; end
if nargin < 9, NG=128; end
if nargin < 8, N=128; end
if nargin < 7, Kshift=128; end
if nargin < 6, Kstart=1; end
if nargin < 5, NK=floor((length(bx)-256)/Kshift); end
if nargin < 4, FSAMP=25; end
if nargin < 3, display('Three field components must be given'); return; end

nfaver=NG/N;

%%% ZEROING FINAL OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vfreqs=zeros(1,(N/2));
vpsd=zeros(1,N/2);
vpsddev=zeros(1,N/2);

%%% CREATING FREQUENCY VECTOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 deltaf = FSAMP/(1.*N);
 for k=1:N/2
    vfreqs(k)=(k-1)*deltaf;
 end
 
%%% ZEROING TIME LOOP PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ftavcxyr=zeros(1,NG);
ftavcxyi=zeros(1,NG);
ftavcxyr2=zeros(1,NG);
ftavcxyi2=zeros(1,NG);
ftavgxp=zeros(1,NG);
ftavgxp2=zeros(1,NG);
ftavgyp=zeros(1,NG);
ftavgyp2=zeros(1,NG);

ftavcyzr=zeros(1,NG);
ftavcyzi=zeros(1,NG);
ftavcyzr2=zeros(1,NG);
ftavcyzi2=zeros(1,NG);
ftavgzp=zeros(1,NG);
ftavgzp2=zeros(1,NG);

ftavczxr=zeros(1,NG);
ftavczxi=zeros(1,NG);
ftavczxr2=zeros(1,NG);
ftavczxi2=zeros(1,NG);    


%%% TIME LOOP STARTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deltat=1./FSAMP;
for i=1:NK
    mstart=Kstart+(i-1)*Kshift;
    
    gx=gaussw(bx,NG,GW,mstart,deltat);
    gy=gaussw(by,NG,GW,mstart,deltat);
    gz=gaussw(bz,NG,GW,mstart,deltat);

    [gxp,gyp,cxyr,cxyi,gxf,gyf]=spectrum(gx,gy,NG,deltat);
    [gyp,gzp,cyzr,cyzi,gyf,gzf]=spectrum(gy,gz,NG,deltat);
    [gzp,gxp,czxr,czxi,gzf,gxf]=spectrum(gz,gx,NG,deltat);

%%% Frequency summing
    [favgxp,favgyp,favgxp2,favgyp2]=freq_sum(N,NG,nfaver,gxp,gyp);
    [favcxyr,favcxyi,favcxyr2,favcxyi2]=freq_sum(N,NG,nfaver,cxyr,cxyi);
    
    [favgyp,favgzp,favgyp2,favgzp2]=freq_sum(N,NG,nfaver,gyp,gzp);
    [favcyzr,favcyzi,favcyzr2,favcyzi2]=freq_sum(N,NG,nfaver,cyzr,cyzi);
    
    [favgzp,favgxp,favgzp2,favgxp2]=freq_sum(N,NG,nfaver,gzp,gxp);
    [favczxr,favczxi,favczxr2,favczxi2]=freq_sum(N,NG,nfaver,czxr,czxi);

%%% Time summing    

    for j=1:N
        ftavcxyr(j)=ftavcxyr(j)+favcxyr(j);
        ftavcxyi(j) = ftavcxyi(j) + favcxyi(j);
        ftavcxyr2(j) = ftavcxyr2(j) + favcxyr2(j);
        ftavcxyi2(j) = ftavcxyi2(j) + favcxyi2(j);
        
        ftavcyzr(j)=ftavcyzr(j)+favcyzr(j);
        ftavcyzi(j) = ftavcyzi(j) + favcyzi(j);
        ftavcyzr2(j) = ftavcyzr2(j) + favcyzr2(j);
        ftavcyzi2(j) = ftavcyzi2(j) + favcyzi2(j);
        
        ftavczxr(j)=ftavczxr(j)+favczxr(j);
        ftavczxi(j) = ftavczxi(j) + favczxi(j);
        ftavczxr2(j) = ftavczxr2(j) + favczxr2(j);
        ftavczxi2(j) = ftavczxi2(j) + favczxi2(j);
        
        ftavgxp(j) = ftavgxp(j) + favgxp(j);
        ftavgyp(j) = ftavgyp(j) + favgyp(j);
        ftavgzp(j) = ftavgzp(j) + favgzp(j);
        
        ftavgxp2(j) = ftavgxp2(j) + favgxp2(j);
        ftavgyp2(j) = ftavgyp2(j) + favgyp2(j);
        ftavgzp2(j) = ftavgzp2(j) + favgzp2(j);
    end

end % END: Time loop


%%% Compute averages
nftaver=nfaver*NK;
    
cxyrdev=zeros(1,N);
cxyidev=zeros(1,N);
cyzrdev=zeros(1,N);
cyzidev=zeros(1,N);
czxrdev=zeros(1,N);
czxidev=zeros(1,N);
gxpdev=zeros(1,N);
gypdev=zeros(1,N);    
gzpdev=zeros(1,N);

for j=1:N
    ftavcxyr(j) = ftavcxyr(j)/(nftaver);
    cxyrdev(j) = ftavcxyr2(j)/nftaver-ftavcxyr(j)*ftavcxyr(j);
    if(cxyrdev(j)<0)
            cxyrdev(j)=0.;
    end

    ftavcxyi(j) = ftavcxyi(j)/(nftaver);
    cxyidev(j) = ftavcxyi2(j)/nftaver-ftavcxyi(j)*ftavcxyi(j);
    if(cxyidev(j)<0)
        cxyidev(j)=0.;
    end
        
    ftavcyzr(j) = ftavcyzr(j)/(nftaver);
    cyzrdev(j) = ftavcyzr2(j)/nftaver-ftavcyzr(j)*ftavcyzr(j);
    if(cyzrdev(j)<0)
            cyzrdev(j)=0.;
    end

    ftavcyzi(j) = ftavcyzi(j)/(nftaver);
    cyzidev(j) = ftavcyzi2(j)/nftaver-ftavcyzi(j)*ftavcyzi(j);
    if(cyzidev(j)<0)
        cyzidev(j)=0.;
    end

    ftavczxr(j) = ftavczxr(j)/(nftaver);
    czxrdev(j) = ftavczxr2(j)/nftaver-ftavczxr(j)*ftavczxr(j);
    if(czxrdev(j)<0)
            czxrdev(j)=0.;
    end

    ftavczxi(j) = ftavczxi(j)/(nftaver);
    czxidev(j) = ftavczxi2(j)/nftaver-ftavczxi(j)*ftavczxi(j);
    if(czxidev(j)<0)
        czxidev(j)=0.;
    end

    
    ftavgxp(j) = ftavgxp(j)/(nftaver);
    gxpdev(j) = ftavgxp2(j)/nftaver-ftavgxp(j)*ftavgxp(j);
    ftavgyp(j) = ftavgyp(j)/(nftaver);
    gypdev(j) = ftavgyp2(j)/nftaver-ftavgyp(j)*ftavgyp(j);
    ftavgzp(j) = ftavgzp(j)/(nftaver);
    gzpdev(j) = ftavgzp2(j)/nftaver-ftavgzp(j)*ftavgzp(j);
    
    
 %%% Compute standard deviations
     
     if(abs(ftavcxyr(j))>0)
           cxyrdev(j)=sqrt(cxyrdev(j)/nftaver);
     end
     
     if(abs(ftavcxyi(j))>0.)
           cxyidev(j)=sqrt(cxyidev(j)/nftaver);
     end
     
     if(abs(ftavcyzr(j))>0)
           cyzrdev(j)=sqrt(cyzrdev(j)/nftaver);
     end
     
     if(abs(ftavcyzi(j))>0.)
           cyzidev(j)=sqrt(cyzidev(j)/nftaver);
     end

     if(abs(ftavczxr(j))>0)
           czxrdev(j)=sqrt(czxrdev(j)/nftaver);
     end
     
     if(abs(ftavczxi(j))>0.)
           czxidev(j)=sqrt(czxidev(j)/nftaver);
     end
     
     if(abs(ftavgxp(j))>0 && gxpdev(j)>0.)
           gxpdev(j) = sqrt(gxpdev(j)/nftaver);
     end
     
     if(abs(ftavgyp(j))>0 && gypdev(j)>0)
           gypdev(j) = sqrt(gypdev(j)/nftaver);
     end
     
     if(abs(ftavgzp(j))>0 && gzpdev(j)>0)
           gzpdev(j) = sqrt(gzpdev(j)/nftaver);
     end

end %%% END: Averaging
    
   
for j=1:N/2 %% Single spectra
%%% Compute total PSD    
    vpsd(j)=ftavgxp(j)+ftavgyp(j)+ftavgzp(j);
    vpsddev(j)=sqrt((ftavgxp(j)*ftavgxp(j))*(gxpdev(j)*gxpdev(j)) ...
        +(ftavgyp(j)*ftavgyp(j))*(gypdev(j)*gypdev(j)) ...
        +(ftavgzp(j)*ftavgzp(j))*(gzpdev(j)*gzpdev(j)))/vpsd(j); 
    vpsdx(j)=ftavgxp(j);
    vpsdxdev(j)=gxpdev(j);
    vpsdy(j)=ftavgyp(j);
    vpsdydev(j)=gypdev(j);
    vpsdz(j)=ftavgzp(j);
    vpsdzdev(j)=gzpdev(j);

end % END: Spectra 



function gt=gaussw(st,NG,GW,m,deltat)
%%% Applying the Gaussian window


gt=zeros(1,NG);

wsum=0;
for i=0:(NG-1)
    win=exp(-((i-NG/2)/GW)*((i-NG/2)/GW));
    gt(i+1)=st(m+i)*win;
    wsum=wsum+win*win;
end

gnorm=sqrt(1/(wsum*deltat));

for j=0:(NG-1)
    gt(j+1)=gt(j+1)*gnorm;
    
end

return

%%% ASSISTING FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [gxp,gyp,cxyr,cxyi,gxf,gyf]=spectrum(gx,gy,NG,deltat)

%%% calculates the cross-spectrum xf * yf^* between the 
% * signals bx and by
% * bx and by contains N points from two real time series.
% * On exit xf and yf contain the FFT's of bx and by respectively 
% * px and py are the power spectra xf*xf^* and yf^yf^*, and 
% * the real  and imaginary parts of the cross-spectrum from 
% * -f_max to +f_max (M = 2*N +1) are in xyr and xyi.
% 
% *
% * N must be a power of 2
% *
% * Transforms properly normalized with dt

gxf=fft(gx,NG);
gyf=fft(gy,NG);

cxyr=zeros(1,NG);
cxyi=zeros(1,NG);
gxp=zeros(1,NG);
gyp=zeros(1,NG);

j=0;
for i=1:NG
    j=j+1;
    gxf(i)=gxf(i)*deltat;
    gyf(i)=gyf(i)*deltat;
    cxyr(j)=real(gxf(i))*real(gyf(i)) + imag(gxf(i))*imag(gyf(i));
    cxyi(j)=imag(gxf(i))*real(gyf(i)) - real(gxf(i))*imag(gyf(i));
    gxp(j)=real(gxf(i))*real(gxf(i))+imag(gxf(i))*imag(gxf(i));
    gyp(j)=real(gyf(i))*real(gyf(i))+imag(gyf(i))*imag(gyf(i));
end

return


function [favgxp,favgyp,favgxp2,favgyp2]=freq_sum(N,NG,nfaver,gxp,gyp)
    
% Does frequency summing

    favgxp=zeros(1,N);
    favgyp=zeros(1,N);
    favgxp2=zeros(1,N);
    favgyp2=zeros(1,N);
    
    
   for k=1:NG
       l=1+floor((k-1)/nfaver);
       favgxp(l)=favgxp(l)+gxp(k);
       favgyp(l)=favgyp(l)+gyp(k);
       favgxp2(l)=favgxp2(l)+gxp(k)*gxp(k);
       favgyp2(l)=favgyp2(l)+gyp(k)*gyp(k);
   end
   
   return
   

