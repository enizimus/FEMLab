function ABCs = calc_abcs(tri_x, tri_y, n_tri, tri_area)

ABCs = zeros(n_tri, 3, 3);

for i_tri = 1:n_tri
    ABCs(i_tri,:,:) = slv.calc_abc(tri_x(i_tri, :), tri_y(i_tri, :), tri_area(i_tri));
end
