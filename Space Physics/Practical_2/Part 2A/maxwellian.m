function f = maxwellian(m, n, T, u, v)
    kb = 1.38066e-23; % Boltzmann constant
    f = n*(m/(2*pi*kb*T)).^(3/2)*exp(-((m*(v-u)*(v-u)')/(2*kb*T)));     
end

