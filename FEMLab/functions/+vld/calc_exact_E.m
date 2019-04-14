function E = calc_exact_E(files, N, r)

Rd = 0.1;
eps_0 = 8.854187e-12;
rho = 10e-11; %charge density

R = linspace(0,1,N);

E = zeros(N,1);
I = R <= Rd;
E(I) = (rho*R(I))/(4*pi*eps_0*Rd^3);
E(~I) = rho./(4*pi*eps_0*R(~I).^2);

end