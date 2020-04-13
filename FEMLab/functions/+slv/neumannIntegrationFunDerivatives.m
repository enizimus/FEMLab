function ds = neumannIntegrationFunDerivatives(side, x, y, iPt, gData)

dN1dXi = -3+4*gData(iPt,1)+4*gData(iPt,2);
dN2dXi = 4*gData(iPt,1)-1;
dN3dXi = 0;
dN4dXi = 4-8*gData(iPt,1)-4*gData(iPt,2);
dN5dXi = 4*gData(iPt,2);
dN6dXi = -4*gData(iPt,2);
dNdXi = [dN1dXi; dN2dXi; dN3dXi; dN4dXi; dN5dXi; dN6dXi];

dN1dEta = -3+4*gData(iPt,1)+4*gData(iPt,2);
dN2dEta = 0;
dN3dEta = 4*gData(iPt,2)-1;
dN4dEta = -4*gData(iPt,1);
dN5dEta = 4*gData(iPt,1);
dN6dEta = 4-4*gData(iPt,1)-8*gData(iPt,2);
dNdEta = [dN1dEta; dN2dEta; dN3dEta; dN4dEta; dN5dEta; dN6dEta];

switch side
    case 1
        xt = x*dNdXi;
        yt = y*dNdXi;
        ds = sqrt(xt^2+yt^2);
    case 2
        xt = x*dNdEta;
        yt = y*dNdEta;
        ds = sqrt(xt^2+yt^2);
    case 3
        xt1 = x*dNdXi;
        yt1 = y*dNdXi;
        xt2 = x*dNdEta;
        yt2 = y*dNdEta;
        ds = sqrt((xt2-xt1)^2+(yt2-yt1)^2);
end