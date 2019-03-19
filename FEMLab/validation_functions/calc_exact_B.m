function B = calc_exact_B(N, x, y, type, opt)

R = 0.2;
msh_r = 0.5;
mu_0 = 1.257e-6;
J = 10e-3;

if(strcmp(type, 'diag'))
    B = zeros(1,N);
    
    if(strcmp(opt, 'circ'))
        r = linspace(0, msh_r, N) > R; %sqrt(x.^2 + y.^2) > R;
    elseif(strcmp(opt, 'rect'))
        r = (x > R) & (y > R);
    end
    
    B(r) = (mu_0*J*R^2)./(2*(sqrt(x(r).^2+y(r).^2)));
    B(~r) = (mu_0*J*(sqrt(x(~r).^2+y(~r).^2)))./2;
end