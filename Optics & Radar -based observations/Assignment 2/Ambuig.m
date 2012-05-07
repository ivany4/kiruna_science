%%
% Anita Enmark, 2011
% Based on code written by Eli Mozeson and Nadav Levanon, Dept. of EE-Systems, Tel Aviv
%
% The original code is from Appendix 3A of the book
% N. Levanon & E. Mozeson, Radar Signals, John Wiley & Sons, Inc., Hoboken, New Jersey (2004)
% available on knovel.com (from LTU network).
%
% NOTE: Script clears all variables in workspace. Save on file after each
% run
% 
%Available relevant binary code variables after script:
%   rxx   - autocorrelation function 
%   a     - ambiguity function
%   delay - delay axis
%   freq  - freqency axis
%   U     - code (for complementary code magnitude, both pulses are included in U]
%   P     - code phase for complementary code

%%
close all
clear all
j=sqrt(-1);


s=sprintf('\n 1: Pulse train\n 2: Long pulse\n 3: Short pulse\n 4: Barker\n 5: Complementary\n 6: LFM\n 7: Combined Barker\n 8: PRN')
coding=input('Coding method (from list above): ');
fcode=0;
switch coding
    case 1
        %6 Pulses
        z=[0 0 0 0];
        U=[0 0 1 z 1 z 1 z 1 z 1 z 1 0 0]
        P=zeros(1,length(U));
    case 2
        %Long Pulse
        U=ones(1,10)
        P=zeros(1,length(U));
    case 3
        %Shorter Pulse
        nn=input('Total length is 10 bits. How many 1s?  ');
        if nn>10
            disp('Choose 1-10')
            return
        end;
        U=[ones(1,nn) zeros(1,10-nn)]
        P=zeros(1,length(U));
    case 4
        codelength=input('Length of code (2,3,4,5,7,11 or 13): ');
        switch codelength
            case 2
                U=[+1 -1]
            case 3
                U=[ +1 +1 -1]
            case 4
                U=[+1 +1 -1 +1]
            case 5
                U=[+1 +1 +1 -1 +1]
            case 7
                U=[+1 +1 +1 -1 -1 +1 -1]
            case 11
                U=[+1 +1 +1 -1 -1 -1 +1 -1 -1 +1 -1]
            case 13
                U=[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1]
            otherwise
                ('Length of code (2,3,4,5,7,11 or 13) ')
                return
        end
        P=zeros(1,length(U));
    case 5
        codelength=input('Length of code (3 or 7): ');
        switch codelength
            case 3
                U=[ones(1,3) zeros(1,7) ones(1,3)];
        P=[0 0 1 zeros(1,7) 0 1/2 0]*pi;
            case 7
                U=[ [1  1  1 -1 1  1  -1 1  zeros(1,15) 1 1 1 -1 -1 -1 1 -1]];
                P=zeros(1,length(U));
        otherwise
                ('Length of code (3 or 7): ')
                return
        end
    case 6
        U=ones(1,51);
        P=zeros(1,length(U));
        fbasic=.0062*[-25:25];
        fcode=1;
    case 7
        codelength=input('For BarkerMN give length of code M (2,3,4,5,7,11 or 13): ');
        switch codelength
            case 2
                UM=[+1 -1]
            case 3
                UM=[ +1 +1 -1]
            case 4
                U=[+1 +1 -1 +1]
            case 5
                UM=[+1 +1 +1 -1 +1]
            case 7
                UM=[+1 +1 +1 -1 -1 +1 -1]
            case 11
                UM=[+1 +1 +1 -1 -1 -1 +1 -1 -1 +1 -1]
            case 13
                UM=[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1]
            otherwise
                ('Length of code (2,3,4,5,7,11 or 13: ')
                return
        end
        codelength=input('For BarkerMN give length of code N (2,3,4): ');
        switch codelength
            case 2
                UN=[+1 -1]
            case 3
                UN=[ +1 +1 -1]
            case 4
                UN=[+1 +1 -1 +1]
            otherwise
                ('N is 2,3 or 4')
                return
        end
        U=[];
        for k=1:codelength
            U=[U UM*UN(k)];
        end
         P=zeros(1,length(U));
         U
         case 8
        codelength=input('Length of code (15, 31): ');
        switch codelength
            case 15
                U=[+1 -1 -1 -1 1 1 1 1 -1 1 -1 1 1 -1 -1]
            case 31
                U=[ +1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 -1 1 1 -1 -1 -1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 -1]
            otherwise
                ('Length of code 15 or 31 ')
                return
        end
        P=zeros(1,length(U));
    otherwise
        disp('Choose 1-8')
        return
end






%% Complex function
ubasic=U.*exp(j*P);
mbasic=length(ubasic);
F=10;
K=100;
df=F/K/mbasic;
T=1 ;
N=200 ;
sr=20 ;
r=ceil(sr*(N+1)/T/mbasic);
%% Pulse 6
% df=0.01;
% r=10;
% N=285;
% K=60;
dt=1/r; % interval between samples
ud=diag(ubasic);
ao=ones(r,mbasic) ;
m=mbasic*r;
ubasic=reshape(ao*ud,1,m);% ubasic with each element repeated r times
uamp=abs(ubasic);
phas=angle(ubasic);
u=ubasic;
if fcode==1
    ff=diag(fbasic);
    phas=2*pi*dt*cumsum(reshape(ao*ff,1,m))+phas;
    uexp=exp(j*phas);
u=uamp.*uexp;
end;
% u-basic with each element repeated r times
t=[0:r*mbasic-1]/r;
tscalel=[0 0:r*mbasic-1 r*mbasic-1]/r;
dphas=[NaN diff(phas)]*r/2/pi;
% plot the signal parameters

%% Calculate a delay vector with N+l points that spans from zero delay to
% ceil(T*t(m))
dtau=ceil(T*m)*dt/N;
tau=round([0:1:N]*dtau/dt)*dt;
%% Calculate K+1 equally spaced grid points of Doppler axis with df spacing
f=[0:1:K]*df;
%% Duplicate Doppler axis to show also negative Doppler's (0 Doppler is
% calculated twice)
f=[-fliplr(f) f];
%% Calculate ambiguity function using sparse matrix manipulations (no loops)
% See matrix  Appendix 3A in [Levanon]

mat1=spdiags(u',0,m+ceil(T*m),m);

%% Define a convolution sparse matrix based on the signal samples ul u2 u3 ...um
% where each row is a time(index) shifted versions of u.
% See matrix  Appendix 3A in [Levanon]
upadded=[zeros(1,ceil(T*m)),u,zeros(1,ceil(T*m))];
cidx=[1:m+ceil(T*m)];
ridx=round(tau/dt)';
index = cidx(ones(N+1,1),:) + ridx(:,ones(1,m+ceil(T*m)));
% calculate matrix
mat2 = sparse(upadded(index));
 
%% Calculate the ambiguity matrix for positive delays given by
% matrix multiplication
% See matrix  Appendix 3A in [Levanon]
uupos=mat2*mat1;
clear mat2 mat1

%% Calculate exponent matrix for full calculation of ambiguity function.
% The exponent matrix is 2*(K+1) rows by m columns where each row represents a possible
% Doppler and each column stands for a different place in u.
e=exp(-j*2*pi*f'*t);
% Calculate ambiguity function for positive delays by calculating the integral
% for each possible delay and Doppler over all entries in u.
apos=abs(e*uupos');
% Normalize ambiguity function to have a maximal value of 1
apos=apos/max(max(apos));
% use the symmetry properties of the ambiguity function to transform the
% negative Doppler positive delay part to negative delay, positive Doppler
a=[flipud(conj(apos(1:K+1,:))) fliplr(apos(K+2:2*K+2,:))];
rxx=a(1,:);

%% Plots

figure(1), clf, hold off
subplot(3,1,1)
plot(tscalel,[0 abs(uamp) 0],'linewidth',1.5)
ylabel(' Amplitude ' )
axis([-inf inf 0 1.2*max(abs(uamp))])
subplot(3,1,2)
plot(t, phas,'linewidth',1.5)
axis([-inf inf -inf inf])
ylabel(' Phase [rad] ' )
subplot(3,1 ,3)
title('Magnitude of autocorrelation function')
% define new delay and Doppler vectors
delay=[-fliplr(tau) tau];
freq=f(K+2:2*K+2)*ceil(max(t));
plot(delay,a(1,:))

figure 
contour(delay,freq,a)
title('Contour plot of | {\it\chi} ({\it\tau}, {\it f_d}) |')
xlabel(' {\it\tau}/{\itt_b}');
ylabel(' {\it f_d} x {\itMt_b}');
axis equal tight

figure
mesh(delay,freq,a) 
xlabel(' {\it\tau}/{\itt_b}');
ylabel(' {\it f_d} x {\itMt_b}');
zlabel( ' | {\it\chi} ({\it\tau}, {\it f_d}) | ' ) ;

figure
imagesc(delay,freq,a)
title('Plot of | {\it\chi} ({\it\tau}, {\it f_d}) | from above')
xlabel(' {\it\tau}/{\itt_b}');
ylabel(' {\itf_d} x {\itMt_b}');
