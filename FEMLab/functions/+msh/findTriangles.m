function ptTris = findTriangles(triangles, nodes, xp, yp)

epsilon = def.get('triangle_area_eps');
nTris = size(triangles, 1);
nPts = size(xp,1)*size(xp,2);
ptTris = zeros(size(xp));
for iPt = 1:nPts
    xlp = xp(iPt); ylp = yp(iPt);
    if(iPt > 1 && util.is_in_tri(xlp, ylp, ...
            [nodes(triangles(ptTris(iPt-1), :)).x], ...
            [nodes(triangles(ptTris(iPt-1), :)).y], ...
            epsilon))
        
        ptTris(iPt) = ptTris(iPt-1);
    else
        for iTri=1:nTris
            x = [nodes(triangles(iTri, :)).x];
            y = [nodes(triangles(iTri, :)).y];
            
            if(util.is_in_tri(xlp,ylp,x,y,epsilon))
                ptTris(iPt) = iTri;
                break;
            end
        end
    end
end

