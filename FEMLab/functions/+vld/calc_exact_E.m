function [E,V] = calc_exact_E(N, Rd, type)
eps_0 = 8.854187e-12;
rho = 1e-8;
switch type
    case 'sphere'
        
        Q = rho*4/3*pi*Rd^3; %charge
        
        vecR = linspace(0,1,N);
        
        E = zeros(N,1);
        I = vecR <= Rd;
        
        E(I) = (Q*vecR(I))/(4*pi*eps_0*Rd^3);
        E(~I) = Q./(4*pi*eps_0*vecR(~I).^2);
        
        V(I) = Q/(4*pi*eps_0*Rd).*(3-vecR(I).^2/Rd^2);
        V(~I) = Q./(2*pi*eps_0*vecR(~I));
        
    case 'cylinder'
        
        r = linspace(0,1,N);
        
        E = zeros(N,1);
        V = zeros(N,1);
        
        I = r<Rd;
        V(I) = rho*(Rd^2-r(I).^2)/(4*eps_0);
        V(~I) = rho*Rd^2/(2*eps_0)*log(Rd./r(~I));
        
        E(I) = rho*r(I)/(2*eps_0);
        E(~I) = rho*Rd^2./(2*eps_0*r(~I));
        
    case 'spheres'
        
        Q = rho*4/3*pi*Rd^3;
        
        x = zeros(1,N);
        y = linspace(0,2,N);
        
        % Sphere 1 :
        yp = 0.5;
        Rd = 0.1;
        r = sqrt(x.^2 + (y-yp).^2);
        I = r <= Rd;
        
        E1 = zeros(size(x));
        
        E1(I) = Q*r(I)./(4*pi*eps_0*Rd^3);
        E1(~I) = Q./(4*pi*eps_0*r(~I).^2);
        
        % Sphere 2 :
        yp = 1;
        Rd = 0.1;
        r = sqrt(x.^2 + (y-yp).^2);
        I = r <= Rd;
        
        E2 = zeros(size(x));
        
        E2(I) = Q*r(I)./(4*pi*eps_0*Rd^3);
        E2(~I) = Q./(4*pi*eps_0*r(~I).^2);
        
        % Image spheres :
        Q = -Q;
        % Sphere 1 :
        yp = 0.5;
        Rd = 0.1;
        r = sqrt(x.^2 + (y+yp).^2);
        I = r <= Rd;
        
        Ei1 = zeros(size(x));
        
        Ei1(I) = Q*r(I)./(4*pi*eps_0*Rd^3);
        Ei1(~I) = Q./(4*pi*eps_0*r(~I).^2);
        
        % Sphere 2 :
        yp = 1;
        Rd = 0.1;
        r = sqrt(x.^2 + (y+yp).^2);
        I = r <= Rd;
        
        Ei2 = zeros(size(x));
        
        Ei2(I) = Q*r(I)./(4*pi*eps_0*Rd^3);
        Ei2(~I) = Q./(4*pi*eps_0*r(~I).^2);
        
        
        E = E1+E2+Ei1+Ei2;
        V = 0;
        
        
end