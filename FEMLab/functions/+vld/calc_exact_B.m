function B = calc_exact_B(N, x, y, r_c, type, msh_opt)

R = 0.2;
mu_0 = 1.257e-6;
J = 10e-3;

if(strcmp(type, 'diag'))
    B = zeros(1,N);
    
    if(strcmp(msh_opt.src, 'circ'))
        r = r_c > R; 
    elseif(strcmp(msh_opt.src, 'rect'))
        r = (x > R) & (y > R);
    end
    
    B(r) = (mu_0*J*R^2)./(2*(sqrt(x(r).^2+y(r).^2)));
    B(~r) = (mu_0*J*(sqrt(x(~r).^2+y(~r).^2)))./2;
end