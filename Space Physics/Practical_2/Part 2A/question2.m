
%% CONSTANT VALUES
unit_mass   = 1.6726E-27;           % mass of a proton
unit_charge = 1.6022E-19;           % unit of a charge

%%
%---------------------------------------------
% Given numbers:
n = 3e6;
T = 1e6;
u = 3e5;
vmin = 0;
vmax = 6e5;
dv = 5e3;
% dv = 2e4;
% dv = 6e4;
% dv = 9e4;

m = 1.0*unit_mass;

%---------------------------------------------
% Bin the velocity space:
v = vmin : dv : vmax;

%---------------------------------------------
% Calculate distribution function
f = zeros(length(v), 1); % Pre-allocate memory for all f values.

% It would be the best to avoid for-loops (use vectorized technique)
for i=1:length(v)
    f(i) =  maxwellian(m, n, T, u, v(i) )
end

%---------------------------------------------
% Plot the results
figure;
subplot(2,1,1);
plot(v, f, '-*');
% plot in log-scale
subplot(2,1,2);
semilogy(v, f, '-*');   % equivalent to plot(v, log10(f) );