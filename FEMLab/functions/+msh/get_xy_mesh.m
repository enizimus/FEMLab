function [X,Y] = get_xy_mesh(msh_opt,xlims,ylims,npoints)

def_type = def.get_edge_opts();
egde_type = def.assign_edge_opts(msh_opt.edge);
switch egde_type
    case def_type(1)
        
        rmax = sum(abs(xlims))/2 - 0.05;
        phi = linspace(0,2*pi,npoints);
        r = linspace(0,rmax,npoints);
        
        [R,PHI] = meshgrid(r,phi);
        X = R.*cos(PHI);
        Y = R.*sin(PHI);
        
    case def_type(2)
        
        x = linspace(xlims(1),xlims(2),npoints);
        y = linspace(ylims(1),ylims(2),npoints);
        [X,Y] = meshgrid(x,y);
        
end