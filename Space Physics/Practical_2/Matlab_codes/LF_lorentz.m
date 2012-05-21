%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function name:  LF_lorentz
% Description: Solving the equation of motion
% Parameters:
%   V:  velocity vector [vx, vy, vz]
%   B:  magnetic field vector [Bx, By, Bz]
%   E:  electric field vector [Ex, Ey, Ez]
%   q:  electric charge
%   m:  particle mass
%  dt:  time step
%
%
% return value:
%    velocity obtained from lorentz equation
%
% By: SHAHAB FATEMI	shahab@irf.se
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v = LF_lorentz(V, B, E, q, m, dt)
    % if we solve a 2D problem
    if( ndims(V) == 2)
        vel = V;
    else % otherwise
        vel(1) = V(1,1,1);
        vel(2) = V(1,1,2);
        vel(3) = V(1,1,3);
    end
    
    % Theoretical solution to the equation of motion, to solve velocity.
    v1 = vel * (1 - (0.5 * power(gyrofreq(q,m,B),2) * power(dt,2)) );
    v2 = q*(dt/m)*(E + cross(vel,B));
    v3 = 0.5 * power( (q*dt/m) ,2) * cross(E,B);
    v4 = 0.5 * power( (q*dt/m) ,2) * dot(vel,B) * B;
    
    % velocity...
    v  = v1 + v2 + v3 + v4;
end
