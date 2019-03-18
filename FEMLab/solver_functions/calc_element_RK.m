function [K,R,U,n] = calc_element_RK(f_K, f_R, nodes, nodes_prop, element, regions_c, elem_tag, opt)

mu_0 = regions_c.mu_0;
%kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[U, i_k, i_n] = set_known_u([element.nodes], nodes_prop, regions_c);

if(regions_c.is_source(elem_tag)) %if region is source
    f = regions_c.get_param(elem_tag); % Stromdichte J
    k1 = 1/mu_0; % \mu of copper of source
else
    f = 0;
    k1 = 1/(regions_c.get_param(elem_tag)*mu_0); % 1/(mu_r * mu_0)
end

k = [k1 k1];
[abc, A] = calc_abc(nodes, [element.nodes]);
[xe, ye] = get_element_xy(nodes, [element.nodes]);

K = zeros(3,3);
R_p = rm(f,A)*ones(3,1);
r_p = zeros(3,1);

if(strcmp(opt, 'integrate'))
    fun = @int_tri;
else
    fun = @pre_int;
end

for i=1:3
    for j=1:3
        b = [abc(2,i),abc(2,j)];
        c = [abc(3,i),abc(3,j)];
        K(i,j) = fun(A, k, b, c, f_K, xe, ye);
    end
end

K_len = max([length(i_k), length(i_n)]);

R_temp = zeros(3,1);
R_temp(i_n) = U(i_k)'*reshape(K(i_n, i_k),[K_len, 1]);
R = R_p - R_temp;
n = i_n;



