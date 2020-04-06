function E = calc_exact_E(N, Rd, type)
eps_0 = 8.854187e-12;
rho = 1e-9;

switch type
    case 'sphere'
        
        Q = rho*4/3*pi*Rd^3; %charge
        
        vecR = linspace(0,1,N);
        
        E = zeros(N,1);
        I = vecR <= Rd;
        
        E(I) = (Q*vecR(I))/(4*pi*eps_0*Rd^3);
        E(~I) = Q./(4*pi*eps_0*vecR(~I).^2);
        
end