function I = integrateR(A, abc, f, fun, x, y)

gData = [0.333333333333333, 0.333333333333333, 0.1125
         0.470142064105115, 0.470142064000000, 0.066197076394253
         0.059715871789770, 0.470142064000000, 0.066197076394253
         0.470142064105115, 0.059715872000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.062969590272414
         0.797426985353087, 0.797426985000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.066197076394253];

nP = 7;
I = 0;

for iPt = 1:nP
    
    % Transformation into unit element (triangle) at (0,0) (1,0) (0,1) : 
    xv = x(1)*(1-gData(iPt,1)-gData(iPt,2))+x(2)*gData(iPt,1)+x(3)*gData(iPt,2);
    yv = y(1)*(1-gData(iPt,1)-gData(iPt,2))+y(2)*gData(iPt,1)+y(3)*gData(iPt,2);
    
    % Gaussian quadrature : sum(f(xi)*wi)
    fv = fun(xv, yv, A, abc);
    I = I + fv*gData(iPt,3);
end

I = f*I*A*2;