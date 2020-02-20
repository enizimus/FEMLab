function [hFunBx, hFunBy] = getBFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.symmetry);

if(type == type1) % planar case
    hFunBx = @(A, ABC) ABC(3,:)*A;
    hFunBy = @(A, ABC, ~, ~) - ABC(2,:)*A;
    
elseif(type == type2) %axissymetric case
    N = @(ABC, r, z) [1 r z]*ABC;
    hFunBx = @(A, ABC) -ABC(3,:)*A;
    hFunBy = @(A, ABC, r, z) N(ABC,r,z)*A/r + ABC(2,:)*A;
end