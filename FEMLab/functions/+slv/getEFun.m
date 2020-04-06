function [hFunEx, hFunEy] = getEFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.symmetry);

if(type == type1 || type == type2) % planar case
    if(optProb.elementOrder == 1)
        hFunEx = @(A, ABC, ~, ~) -ABC(2,:)*A;
        hFunEy = @(A, ABC, ~, ~) -ABC(3,:)*A;
    elseif(optProb.elementOrder == 2)
        dNdx = @(ABC, x, y) [1 2*x y]*ABC([2,4,5],:);
        dNdy = @(ABC, x, y) [1 x 2*y]*ABC([3,5,6],:);
        hFunEx = @(A, ABC, x, y) -dNdx(ABC,x,y)*A;
        hFunEy = @(A, ABC, x, y) -dNdy(ABC,x,y)*A;
    end
elseif(type == type2) %axissymetric case
    if(optProb.elementOrder == 1)
        N = @(ABC, r, z) [1 r z]*ABC;
        hFunEx = @(A, ABC) -ABC(2,:)*A;
        hFunEy = @(A, ABC, ~, ~) -ABC(3,:)*A;
    elseif(optProb.elementOrder == 2)
        dNdr = @(ABC, r, z) [1 2*r z]*ABC([2,4,5],:);
        dNdz = @(ABC, r, z) [1 r 2*z]*ABC([3,5,6],:);
        N = @(ABC, r, z) [1 r z r^2 r*z z^2]*ABC;
        hFunBx = @(A, ABC, r, z) -dNdz(ABC,r,z)*A;
        hFunBy = @(A, ABC, r, z) N(ABC, r, z)*A + dNdr(ABC,r,z)*A;
    end
end