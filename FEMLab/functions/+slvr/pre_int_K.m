function I = pre_int_K(A, k, abc, fun, ~, ~, i, j)
b = [abc(2,i),abc(2,j)];
c = [abc(3,i),abc(3,j)];
I = fun(A, k, b, c);