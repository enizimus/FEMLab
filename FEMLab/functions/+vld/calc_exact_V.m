function V = calc_exact_V(N, Rd, type)
eps_0 = 8.854187e-12;
rho = 1e-9;

switch type
    case 'sphere'
        
        Q = rho*4/3*pi*Rd^3; %charge
        
        vecR = linspace(0,1,N);
        
        V = zeros(N,1);
        I = vecR <= Rd;
        V(I) = Q/(4*pi*eps_0*Rd).*(3-vecR(I).^2/Rd^2);
        V(~I) = Q./(2*pi*eps_0*vecR(~I));
        
end