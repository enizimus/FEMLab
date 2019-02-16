function [K,R,n] = calc_element_RK(nodes, element, regparams, sourparams, elem_tag)

n = 3;

if(elem_tag == 3) %if region is source
    f = sourparams(1); % Stromdichte J
    k1 = regparams(3); % \mu of copper
else
    f = 0;
    k1 = regparams(element.tags(1));
end
k = [k1 k1];
kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[abc, A] = calc_abc(nodes, [element.nodes]);
 
 K = zeros(3,3);
 for i=1:3
     for j=1:3
         K(i,j) = kmn(k,[abc(2,i),abc(2,j)], [abc(3,i),abc(3,j)])/(4*A);
     end
 end
 
 R = rm(f,A)*ones(1,3);
