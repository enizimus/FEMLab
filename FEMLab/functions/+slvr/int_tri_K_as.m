function I = int_tri_K_as(A, k, abc, fun, r, z, i, j)

g_data = slvr.gauss_int_data();
n_p = size(g_data, 1);
%det_J = calc_detJ(x,y);

I = 0;
for i_p = 1:n_p
    rv = r(1)*(1-g_data(i_p,1)-g_data(i_p,2))+r(2)*g_data(i_p,1)+r(3)*g_data(i_p,2);
    zv = z(1)*(1-g_data(i_p,1)-g_data(i_p,2))+z(2)*g_data(i_p,1)+z(3)*g_data(i_p,2);
    I = I + fun(A, abc([i,j],:), rv, zv, k)*g_data(i_p,3);
end

I = I * A;