function calc_E(files, X, Y)

load(files.respth, 'A', 'X', 'Y')

dh = abs(X(1,1)-X(1,2));

[Ex, Ey] = gradient(A, dh);
Ex = -Ex;
Ey = -Ey;
E = sqrt(Ex.^2 + Ey.^2);
save(files.respth, 'E', 'Ex', 'Ey', '-append')