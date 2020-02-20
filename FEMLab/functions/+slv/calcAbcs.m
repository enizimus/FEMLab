function ABCs = calcAbcs(xTri, yTri, nTris, areaTri, calcAbc, nTriNodes)

ABCs = zeros(nTriNodes, nTriNodes, nTris);

for iTri = 1:nTris
    ABCs(:,:,iTri) = calcAbc(xTri(iTri, :)', yTri(iTri, :)', areaTri(iTri)');
end