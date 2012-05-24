function [x_comp y_comp z_comp] = flux(v_x, v_y, v_z, dv, f)
x_comp = 0;
y_comp = 0;
z_comp = 0;
for i=1:length(v_x)
    for j=1:length(v_y)
        for k=1:length(v_z)
            x_comp = x_comp + v_x(i) * f(i, j, k);
            y_comp = y_comp + v_y(j) * f(i, j, k);
            z_comp = z_comp + v_z(k) * f(i, j, k);
        end
    end
end
x_comp = x_comp*(dv^3);
y_comp = y_comp*(dv^3);
z_comp = z_comp*(dv^3);
end