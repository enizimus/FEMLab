function I = integrateNeumann(A, abc, f, fun, x, y, side)

gData = [0.333333333333333, 0.333333333333333, 0.1125
    0.470142064105115, 0.470142064000000, 0.066197076394253
    0.059715871789770, 0.470142064000000, 0.066197076394253
    0.470142064105115, 0.059715872000000, 0.066197076394253
    0.101286507323456, 0.101286507000000, 0.062969590272414
    0.797426985353087, 0.797426985000000, 0.066197076394253
    0.101286507323456, 0.101286507000000, 0.066197076394253];

nP = 7;
I = 0;

switch side
    case 1
        tfun = @(iPt,x,y,gData) y(1)*(1-gData(iPt,1)-gData(iPt,2))+y(2)*gData(iPt,1)+y(3)*gData(iPt,2);
        xt = -x(1)+x(2);
        yt = -y(1)+y(2);
        ds = sqrt(xt^2+yt^2);
    case 2
        tfun = @(iPt,x,y,gData) x(1)*(1-gData(iPt,1)-gData(iPt,2))+x(2)*gData(iPt,1)+x(3)*gData(iPt,2);
        xt = -x(1)+x(3);
        yt = -y(1)+y(3);
        ds = sqrt(xt^2+yt^2);
    case 3
        tfun = @(iPt,x,y,gData) x(1)*(1-gData(iPt,1)-gData(iPt,2))+x(2)*gData(iPt,1)+x(3)*gData(iPt,2);
        xt1 = -x(1)+x(2);
        yt1 = -y(1)+y(2);
        xt2 = -x(1)+x(3);
        yt2 = -y(1)+y(3);
        ds = sqrt((xt2-xt1)^2+(yt2-yt1)^2);
end

for iPt = 1:nP
    
    % Transformation into unit element (triangle) at (0,0) (1,0) (0,1) :
    %xv = x(1)*(1-gData(iPt,1)-gData(iPt,2))+x(2)*gData(iPt,1)+x(3)*gData(iPt,2);
    %yv = y(1)*(1-gData(iPt,1)-gData(iPt,2))+y(2)*gData(iPt,1)+y(3)*gData(iPt,2);
    t = tfun(iPt,x,y,gData);
    
    % Gaussian quadrature : sum(f(xi)*wi)
    fv = fun(t, A, abc);
    I = I + fv*gData(iPt,3);
end

I = f*I*ds;