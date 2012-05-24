function [f] = gyrofrequency(B, m, q)
f = abs(q)*norm(B)/(m*2*pi);
end