function [hFunBx, hFunBy] = getBFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.symmetry);

if(type == type1) % planar case
    hFunBx = @(A, ABC) A'*ABC(2,:)';
    hFunBy = @(A, ABC, ~, ~) - A'*ABC(1,:)';
    
elseif(type == type2) %axissymetric case
    N = @(abc, r, z) [r z 1]*abc;
    hFunBx = @(A, ABC) -A'*ABC(2,:)';
    hFunBy = @(A, ABC, r, z) (A(1)*N(ABC(:,1), r, z) + ...
        A(2)*N(ABC(:,2), r, z) + ...
        A(3)*N(ABC(:,3), r, z))/r + ...
        A'*ABC(1,:)';
end