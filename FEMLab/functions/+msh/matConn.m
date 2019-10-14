function matConnect = matConn(triangles, nNodes)

nTris = size(triangles,1);
matConnect = false(nNodes, nTris);
for iTri = 1:nTris
    matConnect(triangles(iTri,:), iTri) = true;
end