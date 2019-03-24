function Utri = calc_tri_U(U, triangles)

n_tri = size(triangles, 1);
Utri = zeros(1, n_tri);
for i_tri = 1:n_tri
    Utri(i_tri) = mean(U(triangles(i_tri,:)));
end