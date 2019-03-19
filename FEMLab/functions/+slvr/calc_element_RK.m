function [K,R,U,n] = calc_element_RK(f_K, f_R, nodes, nodes_prop, element, regions_c, elem_tag, opt)

mu_0 = regions_c.mu_0;

[U, i_k, i_n] = slvr.set_known_u([element.nodes], nodes_prop, regions_c);

if(regions_c.is_source(elem_tag)) %if region is source
    f = regions_c.get_param(elem_tag); % Stromdichte J
    k1 = 1/mu_0; % \mu of copper of source
else
    f = 0;
    k1 = 1/(regions_c.get_param(elem_tag)*mu_0); % 1/(mu_r * mu_0)
end

k = [k1 k1];
[abc, A] = slvr.calc_abc(nodes, [element.nodes]);
[xe, ye] = hlp.get_element_xy(nodes, [element.nodes]);

K = zeros(3,3);
R_p = zeros(3,1); 

if(strcmp(opt, 'integrate'))
    fun_K = @slvr.int_tri_K;
    fun_R = @slvr.int_tri_R;
else
    fun_K = @slvr.pre_int_K;
    fun_R = @slvr.pre_int_R;
end

for i=1:3
    for j=1:3
        b = [abc(2,i),abc(2,j)];
        c = [abc(3,i),abc(3,j)];
        K(i,j) = fun_K(A, k, b, c, f_K, xe, ye);
    end
    R_p(i) = fun_R(A, abc(:,i), f, f_R, xe, ye);
end

K_len = max([length(i_k), length(i_n)]);

R_temp = zeros(3,1);
R_temp(i_n) = U(i_k)'*reshape(K(i_n, i_k),[K_len, 1]);
R = R_p - R_temp;
n = i_n;



