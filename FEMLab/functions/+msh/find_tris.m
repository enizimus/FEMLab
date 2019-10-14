function p_tris = find_tris(triangles, nodes, xp, yp)

epsilon = def.get('triangle_area_eps');
nTris = size(triangles, 1);
n_points = size(xp,1)*size(xp,2);
p_tris = zeros(size(xp));
for i_p = 1:n_points
    xlp = xp(i_p); ylp = yp(i_p);
    if(i_p > 1 && util.is_in_tri(xlp, ylp, ...
            [nodes(triangles(p_tris(i_p-1), :)).x], ...
            [nodes(triangles(p_tris(i_p-1), :)).y], ...
            epsilon))
        
        p_tris(i_p) = p_tris(i_p-1);
    else
        for i_tri=1:nTris
            x = [nodes(triangles(i_tri, :)).x];
            y = [nodes(triangles(i_tri, :)).y];
            
            if(util.is_in_tri(xlp,ylp,x,y,epsilon))
                p_tris(i_p) = i_tri;
                break;
            end
        end
    end
end

