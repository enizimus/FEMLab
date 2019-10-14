function Utri = calcTriA(U, triangles)

nTris = size(triangles, 1);
Utri = zeros(1, nTris);
for iTri = 1:nTris
    Utri(iTri) = mean(U(triangles(iTri,:)));
end