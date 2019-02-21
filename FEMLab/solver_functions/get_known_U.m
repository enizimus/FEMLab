function U_known = get_known_U(u_known, regions_c)
% will be expanded for case where we have multiple dirichlet boundary
% conditions so that U_know gets updated with them accordingly
u_known = double(u_known);
n_known = nnz(u_known);
U_known = ones(n_known,1).*regions_c.get_param(nonzeros(u_known));

end