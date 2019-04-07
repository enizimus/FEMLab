function tri_area = calc_tri_area(tri_x, tri_y, n_tri)

tri_area = zeros(n_tri,1);
for i_tri = 1:n_tri
    tri_area(i_tri) = slv.calc_detJ(tri_x(i_tri,:), tri_y(i_tri,:))*0.5;
end