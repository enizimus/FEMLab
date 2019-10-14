function connect_mat = make_connect_mat(triangles, n_nodes)

nTris = size(triangles,1);
connect_mat = false(n_nodes, nTris);
for i_tri = 1:nTris
    connect_mat(triangles(i_tri,:), i_tri) = true;
end