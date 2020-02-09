function ABCs = calcAbcs(xTri, yTri, nTris, areaTri, calcAbc)

ABCs = zeros(nTris, 3, 3);

for iTri = 1:nTris
    ABCs(iTri,:,:) = calcAbc(xTri(iTri, :)', yTri(iTri, :)', areaTri(iTri)');
end