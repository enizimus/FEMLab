function I = int_tri_K(A, k, abc, fun, ~, ~, i, j)

g_data = slv.gauss_int_data();
n_p = size(g_data, 1);
%det_J = calc_detJ(x,y);
b = [abc(2,i),abc(2,j)];
c = [abc(3,i),abc(3,j)];

I = 0;
for i_p = 1:n_p
    %     xv = x(1)*(1-g_data(i_p,1)-g_data(i_p,2))+x(2)*g_data(i_p,1)+x(3)*g_data(i_p,2);
    %     yv = y(1)*(1-g_data(i_p,1)-g_data(i_p,2))+y(2)*g_data(i_p,1)+y(3)*g_data(i_p,2);
    I = I + fun(A, k, b, c)*g_data(i_p,3);
end

I = I * A;