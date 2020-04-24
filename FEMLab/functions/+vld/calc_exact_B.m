function B = calc_exact_B(N, r_c, type)

vecR = linspace(0,1,N);
mu_0 = 1.257e-6;
J = 1e-3;

x = linspace(0,1,N);
y = linspace(0,1,N);

if(strcmp(type, 'diag'))
    
    B = zeros(1,N);
    r = vecR > r_c; 
    B(r) = (mu_0*J*r_c^2)./(2*vecR(r));
    B(~r) = (mu_0*J*vecR(~r))./2;
    
else
    
    a = 0.3;
    b = 0.5;
    B = zeros(1,N);
    r = linspace(0,1,N);
    
    B_0 = mu_0*J*(b-a);
    B(r < a) = B_0;
    I = r >= a & r <= b;
    B(I) = B_0*(r(I) - b)/(a-b);
    
end
% load('..\sample_projects\wire_in_plane\results\B_line_values_1D.mat')