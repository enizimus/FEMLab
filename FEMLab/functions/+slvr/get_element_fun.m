function [f_K, f_R] = get_element_fun(prob_opt)

if(strcmp(prob_opt.type, 'planar'))
    if(prob_opt.int == 1)
        f_K = @(A, k, b, c) (k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(4*A^2);
        f_R = @(x,y,abc,A) (abc(1)+abc(2)*x+abc(3)*y)/(2*A);
    else
        f_K = @(A, k, b, c) (k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(4*A);
        f_R = @(f,A) f*A/3;
    end
elseif(strcmp(prob_opt.type, 'axissymetric'))
    
    %N = @(abc, r, z) abc(1) + 2*abc(2)*r + abc(3)*z;
    %f_K = @(A, abc, r, z, k) (k(1)/r*N(abc(1,:),r,z)*N(abc(2,:),r,z)+...
    %   k(2)*r*z^2*abc(1,3)*abc(2,3))/(4*A^2);
    
    f_K = @(A, k, b, c, r) r*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(4*A^2);
    
    f_R = @(r, z, abc, A) r*(abc(1)+abc(2)*r+abc(3)*z)/(2*A);
    
end