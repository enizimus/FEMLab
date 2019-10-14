function [X,Y] = getMeshXY(mshType,xlims,ylims,npoints)

defType = def.getEdgeOpts();
edgeType = def.assignEdgeOpts(mshType.edge);
switch edgeType
    case defType(1)
        
        rmax = sum(abs(xlims))/2 - 0.05;
        phi = linspace(0,2*pi,npoints);
        r = linspace(0,rmax,npoints);
        
        [vecR,PHI] = meshgrid(r,phi);
        X = vecR.*cos(PHI);
        Y = vecR.*sin(PHI);
        
    case defType(2)
        
        x = linspace(xlims(1),xlims(2),npoints);
        y = linspace(ylims(1),ylims(2),npoints);
        [X,Y] = meshgrid(x,y);
        
end