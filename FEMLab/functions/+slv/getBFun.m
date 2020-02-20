function [hFunBx, hFunBy] = getBFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.symmetry);

if(type == type1) % planar case
    if(optProb.elementOrder == 1)
        hFunBx = @(A, ABC, ~, ~) ABC(3,:)*A;
        hFunBy = @(A, ABC, ~, ~) - ABC(2,:)*A;
    elseif(optProb.elementOrder == 2)
        dNdx = @(ABC, x, y) [1 2*x y]*ABC([2,4,5],:);
        dNdy = @(ABC, x, y) [1 x 2*y]*ABC([3,5,6],:);
        
        hFunBx = @(A, ABC, x, y)  dNdy(ABC,x,y)*A;
        hFunBy = @(A, ABC, x, y) -dNdx(ABC,x,y)*A;
    end
    
elseif(type == type2) %axissymetric case
    if(optProb.elementOrder == 1)
        N = @(ABC, r, z) [1 r z]*ABC;
        hFunBx = @(A, ABC, ~, ~) -ABC(3,:)*A;
        hFunBy = @(A, ABC, r, z) N(ABC,r,z)*A/r + ABC(2,:)*A;
    elseif(optProb.elementOrder == 2)
        dNdr = @(ABC, r, z) ABC(:,[2,4,5])*[1; 2*r; z];
        dNdz = @(ABC, r, z) ABC(:,[3,5,6])*[1; r; 2*z];
        N = @(ABC, r, z) [1 r z r^2 r*z z^2]*ABC;
        hFunBx = @(A, ABC, r, z) -A'*dNdz(ABC,r,z);
        hFunBy = @(A, ABC, r, z) N(ABC, r, z)*A + A'*dNdr(ABC,r,z);
    end
end