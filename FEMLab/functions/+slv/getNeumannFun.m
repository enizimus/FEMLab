function [hSideFun1, hSideFun2, hSideFun3] = getNeumannFun(optProb)

if(def.isPlanar(optProb.symmetry))
    
    if(optProb.elementOrder == 1 || optProb.elementOrder == 2) % For first order elements, same for EStatic and MStatic
        
        hSideFun1 = @(t, A, abc) 0.5*(abc(1)+abc(2)*t)/A;
        hSideFun2 = @(t, A, abc) 0.5*(abc(1)+abc(3)*t)/A;
        hSideFun3 = @(t, A, abc) 0.5*(abc(1)+abc(2)*(1-t)+abc(3)*t)/A;
        
    elseif(optProb.elementOrder == 2) % For second order elements, same for EStatic and MStatic
        
        % Partial derivatives of quadr. element function
        dNdx = @(x,y,abc) abc(2) + 2*abc(4)*x + abc(5)*y;
        dNdy = @(x,y,abc) abc(3) + 2*abc(6)*y + abc(5)*x;
        
        hFunElemK = @(x, y, A, k, abc) 0.25/A^2*(k(1)*dNdx(x,y,abc(:,1))*dNdx(x,y,abc(:,2))+...
            k(2)*dNdy(x,y,abc(:,1))*dNdy(x,y,abc(:,2)));
        
        hFunElemR = @(x, y, A, abc) 0.5/A*(abc(1)+abc(2)*x+abc(3)*y+...
            abc(4)*x^2+abc(5)*x*y+abc(6)*y^2); % + neumann (for now zero)
    end
    
elseif(def.isRotsym(optProb.symmetry))
    
    if(def.isMstatic(optProb.problemClass)) % magnetostatic rot-sym case
        
        if(optProb.elementOrder == 1)
            N = @(abc, r, z) (abc(1) + abc(2)*r + abc(3)*z);
            
            hFunElemK = @(r, z, A, k, abc) 0.25*(k(1)*((N(abc(:,1),r,z)*N(abc(:,2),r,z))/r + ...
                N(abc(:,1),r,z)*abc(2,2) + N(abc(:,2),r,z)*abc(2,1)+...
                r*abc(2,2)*abc(2,1))+...
                k(2)*r*(abc(3,1)*abc(3,2)))/(A^2);
            
            hFunElemR = @(r, z, A, abc) 0.5*r*(abc(1)+abc(2)*r+abc(3)*z)/(A);
            
        elseif(optProb.elementOrder == 2)
            
            % Partial derivatives of quadr. element function
            dNdr = @(r,z,abc) abc(2) + 2*abc(4)*r + abc(5)*z;
            dNdz = @(r,z,abc) abc(3) + 2*abc(6)*z + abc(5)*r;
            
            N = @(r,z,abc) abc(1)+abc(2)*r+abc(3)*z+abc(4)*r^2+abc(5)*r*z+abc(6)*z^2;
            
            hFunElemK = @(r, z, A, k, abc) 0.25/A^2*r*(k(2)*(N(r,z,abc(:,1)*N(r,z,abc(:,2)))/r^2 + ...
                N(r,z,abc(:,1))*dNdr(r,z,abc(:,2))/r + ...
                N(r,z,abc(:,2))*dNdr(r,z,abc(:,1))/r + ...
                dNdr(r,z,abc(:,1))*dNdr(r,z,abc(:,2))) + ...
                k(1)*dNdz(r,z,abc(:,1))*dNdz(r,z,abc(:,2)));
            
            hFunElemR = @(r, z, A, abc) 0.5/A*r*N(r,z,abc);
        end
        
    elseif(def.isEstatic(optProb.problemClass)) % electrostatic rot-sym case
        
        if(optProb.elementOrder == 1)
            
            hFunElemK = @(r, ~, A, k, abc) 0.25*r*(k(1)*abc(2,1)*abc(2,2) + k(2)*abc(3,1)*abc(3,2))/(A^2);
            hFunElemR = @(r, z, A, abc) 0.5*r*(abc(1)+abc(2)*r+abc(3)*z)/(A);
            
        elseif(optProb.elementOrder == 2)
            
            % Partial derivatives of quadr. element function
            dNdr = @(r,z,abc) abc(2) + 2*abc(4)*r + abc(5)*z;
            dNdz = @(r,z,abc) abc(3) + 2*abc(6)*z + abc(5)*r;
            
            hFunElemK = @(r, z, A, k, abc) 0.25/A^2*r*(k(1)*dNdr(r,z,abc(:,1))*dNdr(r,z,abc(:,2)) +...
                k(2)*dNdz(r,z,abc(:,1))*dNdz(r,z,abc(:,2)));
            
            hFunElemR = @(r, z, A, abc) 0.5/A*r*(abc(1)+abc(2)*r+abc(3)*z+abc(4)*r^2+abc(5)*r*z+abc(6)*z^2);
            
        end
        
    end
    
end