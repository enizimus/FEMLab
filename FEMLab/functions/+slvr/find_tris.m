function p_tris = find_tris(triangles, nodes, xp, yp)

epsilon = 1e-5;
n_tri = size(triangles, 1);
n_points = size(xp,1)*size(xp,2);
p_tris = zeros(size(xp));
for i_p = 1:n_points
    xlp = xp(i_p); ylp = yp(i_p);
    for i_tri=1:n_tri
        x = [nodes(triangles(i_tri, :)).x];
        y = [nodes(triangles(i_tri, :)).y];
        
        Atst =  polyarea([xlp, x(1), x(2)], [ylp, y(1), y(2)]) + ...
            polyarea([xlp, x(2), x(3)], [ylp, y(2), y(3)]) + ...
            polyarea([xlp, x(3), x(1)], [ylp, y(3), y(1)]);
        A = polyarea(x,y);
        
        if( abs(A - Atst) < epsilon )
            p_tris(i_p) = i_tri;
            break;
        end
    end
end

