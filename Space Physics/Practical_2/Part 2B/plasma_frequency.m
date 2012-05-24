function [w] = plasma_frequency(n, e, m)
    E_0 = 8.854E-12;
    w = sqrt((n*e^2)/(m*E_0))/(2*pi);
end