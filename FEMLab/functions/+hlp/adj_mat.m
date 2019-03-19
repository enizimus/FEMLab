function I = adj_mat(triangles, n_tri, n_nodes)

I = false(n_nodes, n_nodes);

for node = 1:n_nodes
    
    for i_tri = 1:n_tri
        tri = triangles(i_tri,:);
        L = tri == node;
        if(any(L))
            I(node,tri(~L)) = 1;
        end
    end
end

I = sparse(triu(I));
