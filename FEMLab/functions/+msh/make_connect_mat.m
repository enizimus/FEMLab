function connect_mat = make_connect_mat(triangles, nNodes)

nTris = size(triangles,1);
connect_mat = false(nNodes, nTris);
for i_tri = 1:nTris
    connect_mat(triangles(i_tri,:), i_tri) = true;
end