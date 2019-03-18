function [f_K, f_R] = get_element_fun(opt)

if(strcmp(opt, 'int') || strcmp(opt, 'integral') ...
        || strcmp(opt, 'integrate'))
    
    f_K = @(A, k, b, c) (k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(4*A^2);
    f_R = @(f,A) f*A/3; 
else
    f_K = @(A, k, b, c) (k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(4*A);
    f_R = @(f,A) f*A/3; 
end