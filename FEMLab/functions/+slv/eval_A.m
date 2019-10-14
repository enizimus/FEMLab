function eval_A(files)

load(files.respth, 'triangles', 'x', 'y', 'Ap',...
    'X', 'Y')

nPts = size(X,1)*size(X,2);
A = zeros(size(X));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, X(:), Y(:));

N = slv.get_funs('formfun');

for iPt = 1:nPts
    if isnan(surr_tri(iPt))
        point_ID = nearestNeighbor(TRI, X(iPt), Y(iPt));
        point_near = [x(point_ID),y(point_ID)];
        point = [X(iPt), Y(iPt)];
        delta_dist = pdist([point_near;point]);
        mindistance = min(pdist([x,y]));
        
        if delta_dist<mindistance
            [row,~]=find(triangles==point_ID);
            surr_tri(iPt)=row(1);
        else
            A(iPt)=nan;
            continue;
        end
    end
    I = triangles(surr_tri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(X(iPt), Y(iPt), ABC');
    A(iPt) = Ap(I)'*N_form;
end

save(files.respth, 'A', '-append')

