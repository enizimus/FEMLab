function [hSideFun1, hSideFun2, hSideFun3] = getNeumannFun(optProb)

hSideFun1 = @(t, A, abc) 0.5*(abc(1)+abc(2)*t)/A;
hSideFun2 = @(t, A, abc) 0.5*(abc(1)+abc(3)*t)/A;
hSideFun3 = @(t, A, abc) 0.5*(abc(1)+abc(2)*(1-t)+abc(3)*t)/A;