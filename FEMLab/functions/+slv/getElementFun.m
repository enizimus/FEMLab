function [hFunElemK, hFunElemR] = getElementFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.type);

if(type == type1)
    if(optProb.int == 1) % magnetostatic & electrostatic planar case for integration
        
        hFunElemK = @(A, k, b, c) 0.25*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(A^2);
        
        hFunElemR = @(x,y,abc,A) 0.5*(abc(1)+abc(2)*x+abc(3)*y)/(A);
    
    else % magnetostatic & electrostatic planar case for direct calculation
    
        hFunElemK = @(A, k, b, c) 0.25*(k(1)*b(1)*b(2) + k(2)*c(1)*c(2))/(A); 
        
        hFunElemR = @(f,A) f*A*0.333333333333333;                             
    
    end
elseif(type == type2)
    
    if(def.isMstatic(optProb.class)) % magnetostatic rot-sym case
       
        N = @(abc, r, z) (abc(1) + abc(2)*r + abc(3)*z);
        
        hFunElemK = @(A, abc, r, z, k) 0.25*(k(1)*((N(abc(:,1),r,z)*N(abc(:,2),r,z))/r + ...
            N(abc(:,1),r,z)*abc(2,2) + N(abc(:,2),r,z)*abc(2,1)+...
            r*abc(2,2)*abc(2,1))+...
            k(2)*r*(abc(3,1)*abc(3,2)))/(A^2);
        
        hFunElemR = @(r, z, abc, A) 0.5*r*(abc(1)+abc(2)*r+abc(3)*z)/(A);
        
    else % electrostatic rot-sym case
        
        hFunElemK = @(A, abc, r, ~, k) 0.25*r*(k(1)*abc(2,1)*abc(2,2) + k(2)*abc(3,1)*abc(3,2))/(A^2);
        
        hFunElemR = @(r, z, abc, A) 0.5*r*(abc(1)+abc(2)*r+abc(3)*z)/(A);
    
    end
    
end