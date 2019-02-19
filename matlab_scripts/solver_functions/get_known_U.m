function U_known = get_known_U(u_known, regparams)
% will be expanded for case where we have multiple dirichlet boundary
% conditions so that U_know gets updated with them accordingly
n_known = sum(u_known);
U_known = ones(n_known,1)*regparams(Regions.DIRICHLET);

end