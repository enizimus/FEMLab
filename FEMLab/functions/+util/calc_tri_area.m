function tri_area = calc_tri_area(xTri, yTri, nTris)

tri_area = zeros(nTris,1);
for iTri = 1:nTris
    tri_area(iTri) = slv.calc_detJ(xTri(iTri,:), yTri(iTri,:))*0.5;
end