%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Particle motion
% 
% Aim: To solve the equation of motion and study the particle motion
%
% Assumption: Both electric and magnetic fields are assumed to be constant.
%
% By: SHAHAB FATEMI	shahab@irf.se
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear all;                          % freeing up system memory
clc;                                % Clear Command Window

%% CONSTANT VALUES
unit_mass   = 1.6726E-27;           % mass of a proton
unit_charge = 1.6022E-19;           % unit of a charge

%% PARTICLES MASS AND CHARGE
mass = 1.0*unit_mass;               % mass of a particle
q    = 1.0*unit_charge;             % charge of a particle

%% SOLAR WIND PARAMETERS
B_sw = [0.0    0.0    0.0];  % Interplanetary Magnetic Field (IMF)
u_sw = [0.0    0.0    0.0];  % Solar wind velocity
E_sw = -cross(u_sw, B_sw);   % Convective electric field

%% INITIAL CONDITIONS
r_init = [0.0    0.0    0.0];  % particle's initial position
v_init = [0.0    0.0    0.0];  % particle's initial velocity

%% RUNNING TIME PARAMETERS
dt        = 0.0;                    % single time step
max_time  = 0.0;                    % maximum running time
num_steps = max_time / dt;          % number of time steps

%% MEMORY PRE-ALLOCATION
r = zeros(num_steps+1, 3);          % position array (pre-allocate memory)
v = zeros(num_steps+1, 3);          % velocity array (pre-allocate memory)

%% THE EQUATION OF MOTION SOLVER
% The method is called "Leap-Frog". It's a 1st order ODE solver.
% Leap-Frog has a problem to be started.
% Here we have solved the starting problem.
r(1,:) = r_init;
v(1,:) = LF_lorentz (v_init, B_sw, E_sw, q, mass, -0.5*dt);

% move the particle in the E and B field.
for i=1:num_steps
    r(i+1,:) = r(i,:) + (v(i,:)*dt);
    v(i+1,:) = LF_lorentz (v(i,:), B_sw, E_sw, q, mass, dt);
end


%% Uncomment this section to solve task 10.
% B_sw = [0.0     0.0     0.0];  % Interplanetary Magnetic Field (IMF)
% u_sw = [0.0     0.0     0.0];  % Solar wind velocity
% E_sw = -cross(u_sw, B_sw);     % Convective electric field
% 
% for i=(num_steps/2)+1:num_steps
%     r(i+1,:) = r(i,:) + (v(i,:)*dt);
%     v(i+1,:) = LF_lorentz (v(i,:), B_sw, E_sw, q, mass, dt);
% end

%% Find the velocity magnitude and particle's energy.
v_mag = sqrt( v(:,1).^2 + v(:,2).^2 + v(:,3).^2 );   % velocity magnitude
eng   = 0.5*mass*v_mag.^2/unit_charge;               % energy

%% PLOT RESULTS
figure;

% plot particle's trajectory in the configuration space
subplot(2,2,1);
plot3(r(1,1)/1000, r(1,2)/1000, r(1,3)/1000 , 'o'); % mark the start point
hold on; grid on;
plot3(r(:,1)/1000, r(:,2)/1000, r(:,3)/1000 );
set(gca, 'fontsize', 14);
xlabel('X (km)', 'fontsize', 14);
ylabel('Y (km)', 'fontsize', 14);
zlabel('Z (km)', 'fontsize', 14);
title('Trajectory', 'fontsize', 14);

subplot(2,2,2);
% plot particle's velocity in the velocity space
plot3(v(1,1)/1000, v(1,2)/1000, v(1,3)/1000, 'o' ); % mark the start point
hold on; grid on;
plot3(v(:,1)/1000, v(:,2)/1000, v(:,3)/1000 );
set(gca, 'fontsize', 14);
xlabel('V_x (km/s)', 'fontsize', 14);
ylabel('V_y (km/s)', 'fontsize', 14);
zlabel('V_z (km/s)', 'fontsize', 14);
title('Velocity', 'fontsize', 14);

subplot(2,2,3);
% plot the different velocity components
plot(0:dt:max_time, v(:,1)/1000, 'Color', 'blue');
hold on; grid on;
plot(0:dt:max_time, v(:,2)/1000, 'Color', 'red');
plot(0:dt:max_time, v(:,3)/1000, 'Color', 'black');
set(gca, 'fontsize', 14);
xlabel('Time (sec)', 'fontsize', 14);
ylabel('Velocity (km/s)', 'fontsize', 14);
title('Velocity', 'fontsize', 14);
legend('V_x', 'V_y', 'V_z');

subplot(2,2,4);
% plot the particle's energy as a function of time
plot(0:dt:max_time, eng, 'Color', 'black');
grid on;
set(gca, 'fontsize', 14);
xlabel('Time (sec)', 'fontsize', 14);
ylabel('Energy (eV)', 'fontsize', 14);
title('Energy', 'fontsize', 14);



