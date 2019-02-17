function [K,R,U] = calc_element_RK(nodes, nodes_prop, element, regparams, sourparams, elem_tag)

kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[U, i_k, i_n] = set_known_u([element.nodes], nodes_prop, regparams);

if(elem_tag == 3) %if region is source
    f = sourparams(1); % Stromdichte J
    k1 = regparams(3); % \mu of copper of source
else
    f = 0;
    k1 = regparams(elem_tag);
end
k = [k1 k1];

[abc, A] = calc_abc(nodes, [element.nodes]);
 
 K_p = zeros(3,3);
 for i=1:3
     for j=1:3
         K_p(i,j) = kmn(k,[abc(2,i),abc(2,j)], [abc(3,i),abc(3,j)])/(4*A);
     end
 end
 
 R_p = rm(f,A)*ones(3,1);
 
 K_len = max([length(i_k), length(i_n)]);
 K = K_p(i_n, i_n);
 
 R = R_p(i_n) - U(i_k)'*reshape(K_p(i_n, i_k),[K_len, 1]);
 
 
 
