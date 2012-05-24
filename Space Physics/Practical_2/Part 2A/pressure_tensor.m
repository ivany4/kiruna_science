function [tensor] = pressure_tensor(v_x, v_y, v_z, dv, f, u_sw, mass)
tensor = zeros(3,3);
for i=1:length(v_x)
    for j=1:length(v_y)
        for k=1:length(v_z)
            c_s = [v_x(i) v_y(j) v_z(k)] - u_sw;
            C = mtimes(transpose(c_s), c_s);
            tensor = tensor + C * f(i, j, k);
        end
    end
end
tensor = mass * tensor * (dv^3);
end