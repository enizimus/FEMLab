function [K,R,U,n] = integrate_element_RK(nodes, nodes_prop, element, regions_c, elem_tag)

mu_0 = regions_c.mu_0; % keep
kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[U, i_k, i_n] = set_known_u([element.nodes], nodes_prop, regions_c); % keep

if(regions_c.is_source(elem_tag)) %if region is source
    f = regions_c.get_param(elem_tag); % Stromdichte J
    k1 = 1/mu_0; % \mu of copper of source
else
    f = 0;
    k1 = 1/(regions_c.get_param(elem_tag)*mu_0); % 1/(mu_r * mu_0)
end

k = [k1 k1];

[abc, A] = calc_abc(nodes, [element.nodes]); % keep
K = zeros(3,3);
R_p = rm(f,A)*ones(3,1);

for i=1:3
    for j=1:3
        f = @(x,y) = k(1)*a
        K(i,j) = kmn(k,[abc(2,i),abc(2,j)], [abc(3,i),abc(3,j)])/(4*A);
    end
end

K_len = max([length(i_k), length(i_n)]);

R_temp = zeros(3,1);
R_temp(i_n) = U(i_k)'*reshape(K(i_n, i_k),[K_len, 1]);
R = R_p - R_temp;
n = i_n;
