function ABCs = calcAbcs(xTri, yTri, nTris, areaTri)

ABCs = zeros(nTris, 3, 3);

for iTri = 1:nTris
    ABCs(iTri,:,:) = slv.calcAbc(xTri(iTri, :), yTri(iTri, :), areaTri(iTri));
end
