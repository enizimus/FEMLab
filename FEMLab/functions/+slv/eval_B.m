function [B, Bx, By] = eval_B(files, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Bp', 'Bpx', 'Bpy')
                
if(nargin < 2 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

n_points = size(X,1)*size(X,2);
B = zeros(size(X));
Bx = zeros(size(X));
By = zeros(size(X));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, X(:), Y(:));

N = slv.get_funs('formfun');

for i_p = 1:n_points
    if isnan(surr_tri(i_p))
        point_ID = nearestNeighbor(TRI, X(i_p), Y(i_p));
        point_near = [x(point_ID),y(point_ID)];
        point = [X(i_p), Y(i_p)];
        delta_dist = pdist([point_near;point]);
        mindistance = min(pdist([x,y]));
        
        if delta_dist<mindistance
            [row,~]=find(triangles==point_ID);
            surr_tri(i_p)=row(1);
        else
            B(i_p)=nan;
            Bx(i_p)=nan;
            By(i_p)=nan;
            continue;
        end

    end
    I = triangles(surr_tri(i_p), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(X(i_p), Y(i_p), ABC');
    B(i_p) = Bp(I)*N_form;
    Bx(i_p) = Bpx(I)*N_form;
    By(i_p) = Bpy(I)*N_form;
end

