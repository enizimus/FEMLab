function ABCs = calc_abcs(xTri, yTri, nTris, tri_area)

ABCs = zeros(nTris, 3, 3);

for iTri = 1:nTris
    ABCs(iTri,:,:) = slv.calc_abc(xTri(iTri, :), yTri(iTri, :), tri_area(iTri));
end
