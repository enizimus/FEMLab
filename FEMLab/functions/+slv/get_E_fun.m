function [f_Ex, f_Ey] = get_E_fun(prob_opt)

[type1, type2] = def.get_prob_type_vals();
type = def.get_prob_type(prob_opt.type);

if(type == type1) % planar case
    f_Ex = @(A, ABC) -A'*ABC(1,:)';
    f_Ey = @(A, ABC, ~, ~) -A'*ABC(2,:)';
    
elseif(type == type2) %axissymetric case
    N = @(abc, r, z) [r z 1]*abc;
    f_Ex = @(A, ABC) -A'*ABC(2,:)';
    f_Ey = @(A, ABC, r, z) (A(1)*N(ABC(:,1), r, z) + ...
        A(2)*N(ABC(:,2), r, z) + ...
        A(3)*N(ABC(:,3), r, z))/r + ...
        A'*ABC(1,:)';
    
end