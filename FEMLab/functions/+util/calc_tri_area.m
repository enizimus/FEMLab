function tri_area = calc_tri_area(tri_x, tri_y, nTris)

tri_area = zeros(nTris,1);
for i_tri = 1:nTris
    tri_area(i_tri) = slv.calc_detJ(tri_x(i_tri,:), tri_y(i_tri,:))*0.5;
end