function Utri = calc_tri_U(U, triangles)

nTris = size(triangles, 1);
Utri = zeros(1, nTris);
for i_tri = 1:nTris
    Utri(i_tri) = mean(U(triangles(i_tri,:)));
end