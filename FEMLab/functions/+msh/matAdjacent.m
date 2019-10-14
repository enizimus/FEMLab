function I = matAdjacent(triangles, nTris, nNodes)

I = false(nNodes, nNodes);

for node = 1:nNodes
    
    for iTri = 1:nTris
        tri = triangles(iTri,:);
        L = tri == node;
        if(any(L))
            I(node,tri(~L)) = 1;
        end
    end
end

I = sparse(triu(I));
