function I = integrateKas(A, k, abc, fun, r, z, i, j) 

gData = [0.333333333333333, 0.333333333333333, 0.1125
         0.470142064105115, 0.470142064000000, 0.066197076394253
         0.059715871789770, 0.470142064000000, 0.066197076394253
         0.470142064105115, 0.059715872000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.062969590272414
         0.797426985353087, 0.797426985000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.066197076394253];
nP = 7;

b = [abc(2,i),abc(2,j)];
c = [abc(3,i),abc(3,j)];

I = 0;
for iPt = 1:nP
    % Transformation into unit element (triangle) at (0,0) (1,0) (0,1) : 
    rv = r(1)*(1-gData(iPt,1)-gData(iPt,2))+r(2)*gData(iPt,1)+r(3)*gData(iPt,2);
    zv = z(1)*(1-gData(iPt,1)-gData(iPt,2))+z(2)*gData(iPt,1)+z(3)*gData(iPt,2);
    
    % Gaussian quadrature : sum(f(xi)*wi)
    I = I + fun(rv, zv, A, k, abc(:,[i j]))*gData(iPt,3); 
end

I = I * A * 2;