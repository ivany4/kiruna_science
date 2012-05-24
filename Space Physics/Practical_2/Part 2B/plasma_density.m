function [n] = plasma_density(f, e, m)
    E_0 = 8.854E-12;
    w = 2*pi*f;
    n = w^2*m*E_0/e^2;
end