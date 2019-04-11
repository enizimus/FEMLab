function [f_K, f_R] = get_element_fun(prob_opt)

[type1, type2] = def.get_prob_type_vals();
type = def.get_prob_type(prob_opt.type);

if(type == type1)
    if(prob_opt.int == 1)
        f_K = @(A, k, b, c) 0.25*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(A^2);
        f_R = @(x,y,abc,A) 0.5*(abc(1)+abc(2)*x+abc(3)*y)/(A);
    else
        f_K = @(A, k, b, c) 0.25*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(A);
        f_R = @(f,A) f*A*0.333333333333333;
    end
elseif(type == type2)
    
    N = @(abc, r, z) (abc(1) + abc(2)*r + abc(3)*z);
    f_K = @(A, abc, r, re, ze, k) 0.5*k(1)*(N(abc(:,1),re(1),ze(1))*N(abc(:,2),re(2),ze(2)))/(A*r)+...
        0.25*k(1)*(N(abc(:,2),re(2),ze(2))*abc(2,2)+N(abc(:,2),re(2),ze(2))*abc(2,1)+abc(2,2)*abc(2,1))/(A^2)+...
        0.25*k(2)*r*(abc(3,1)*abc(3,2))/(A^2);
    
    %f_K = @(A, k, b, c, r) 0.25*r*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(A^2);
    
    f_R = @(r, z, abc, A) 0.5*r*(abc(1)+abc(2)*r+abc(3)*z)/(A);
    
end