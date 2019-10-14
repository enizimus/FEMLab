function I = adj_mat(triangles, nTris, nNodes)

I = false(nNodes, nNodes);

for node = 1:nNodes
    
    for i_tri = 1:nTris
        tri = triangles(i_tri,:);
        L = tri == node;
        if(any(L))
            I(node,tri(~L)) = 1;
        end
    end
end

I = sparse(triu(I));
