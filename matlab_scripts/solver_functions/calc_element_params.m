function [K,R] = calc_element_params(elements, i_elem)

rho;
k = [k1, k2];
kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[abc, A] = calc_abc(nodes, [elements(i_elem).nodes]);
 
 K = zeros(3,3);
 for i=1:3
     for j=1:3
         K(i,j) = kmn(k,[abc(2,i),abc(2,j)], [abc(3,i),abc(3,j)])/(4*A);
     end
 end
 
 
 R = [];
