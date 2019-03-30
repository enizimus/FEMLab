function I = int_tri_K_as(A, k, abc, fun, r, ~, i, j)

g_data = slv.gauss_int_data();
n_p = size(g_data, 1);
%det_J = calc_detJ(x,y);
b = [abc(2,i),abc(2,j)];
c = [abc(3,i),abc(3,j)];

I = 0;
for i_p = 1:n_p
    rv = r(1)*(1-g_data(i_p,1)-g_data(i_p,2))+r(2)*g_data(i_p,1)+r(3)*g_data(i_p,2);
    %zv = z(1)*(1-g_data(i_p,1)-g_data(i_p,2))+z(2)*g_data(i_p,1)+z(3)*g_data(i_p,2);
    I = I + fun(A, k, b, c, rv)*g_data(i_p,3); % (A, k, b, c, r)
end

I = I * A;