function [K,R,U,n] = calc_element_RK(U, fun_K, fun_R, f_K, f_R, nodes, nodes_prop, element, regions_c, elem_tag, A, abc, xe, ye, m, is_sour, I)

i_k = find(I ~= 0);
i_n = 1:3;
i_n(i_k) = [];
if(isempty(i_k)), i_k = 1; end

mu_0 = 1.2566e-06; %regions_c.mu_0;

if(is_sour) %if region is source
    f = m; % Stromdichte J
    k1 = 1/mu_0; % \mu of copper of source
else
    f = 0;
    k1 = 1/(m*mu_0); % 1/(mu_r * mu_0)
end

k = [k1 k1];

K = zeros(3,3);
R_p = zeros(3,1);

for i=1:3
    for j=1:3
        K(i,j) = fun_K(A, k, abc, f_K, xe, ye, i, j);
    end
    R_p(i) = fun_R(A, abc(:,i), f, f_R, xe, ye);
end

K_len = max([length(i_k), length(i_n)]);

R_temp = zeros(3,1);
R_temp(i_n) = U(i_k)'*reshape(K(i_n, i_k),[K_len, 1]);
R = R_p - R_temp;
n = i_n;



