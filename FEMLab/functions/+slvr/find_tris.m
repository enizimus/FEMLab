function p_tris = find_tris(triangles, nodes, xp, yp)

epsilon = 1e-10;
n_tri = size(triangles, 1);
n_points = length(xp);
p_tris = zeros(n_points, 1);
for i_p = 1:n_points
    xlp = xp(i_p); ylp = yp(i_p);
    for i_tri=1:n_tri
        x = [nodes(triangles(i_tri, :)).x];
        y = [nodes(triangles(i_tri, :)).y];
        
        d1 = (y(2) - y(1))*(xlp - x(1)) + (-x(2) + x(1))*(ylp - y(1));
        d2 = (y(3) - y(2))*(xlp - x(2)) + (-x(3) + x(2))*(ylp - y(2));
        d3 = (y(1) - y(3))*(xlp - x(3)) + (-x(1) + x(3))*(ylp - y(3));
        
%         w1 = (x(1)*(y(3)-y(1))+(ylp-y(1))*(x(3)-x(1))-xlp*(y(3)-y(1)))/(...
%             (y(2)-y(1))*(x(3)-x(1))-(x(2)-x(1))*(y(3)-y(1)));
%         w2 = (ylp-y(1)-w1*(y(2)-y(1)))/(y(3)-y(1));
%         
%         w12 = w1 + w2;
        %disp(['w1 : ' num2str(w1) ' w2 : ' num2str(w2) ' w3 : ' num2str(w12)])
        
        if( d1 >= 0 & d2 >= 0 & d3 >= 0)
            p_tris(i_p) = i_tri;
            break;
        else
            minx = min(x) - epsilon;
            maxx = max(x) + epsilon;
            miny = min(y) - epsilon;
            maxy = max(y) + epsilon;
            if(~(xlp < minx | xlp > maxx | ylp < miny | ylp > maxy))
                p_tris(i_p) = i_tri;
                %disp('found him ------')
                break;
            end
        end
    end
end

