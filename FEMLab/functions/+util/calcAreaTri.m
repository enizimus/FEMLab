function areaTri = calcAreaTri(xTri, yTri, nTris)

areaTri = zeros(nTris,1);
for iTri = 1:nTris
    areaTri(iTri) = slv.calcDetJ(xTri(iTri,:), yTri(iTri,:))*0.5;
end