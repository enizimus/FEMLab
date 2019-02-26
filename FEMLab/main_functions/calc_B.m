function calc_B(files)
disp('-Calculating magnetic field ...')
tic
load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes')

n_tri = length(triangles);
I = adj_mat(triangles, n_tri, n_nodes);
n_nz = nnz(I);

B = zeros(n_nz,1);
nodes_B = zeros(n_nz, 2);
epsi = 1e-15;

i_B = 1;
for i=1:n_nodes-1
    for j=i+1:n_nodes
        
        if(I(i,j))
            dx = nodes(i).x - nodes(j).x;
            dy = nodes(i).y - nodes(j).y;
            dA = U(i) - U(j);
            
            if( abs(dA) < epsi ), B(i_B) = 0;
            elseif ( abs(dx) < epsi ), B(i_B) = abs(dA/dy);
            elseif ( abs(dy) < epsi ), B(i_B) = abs(-dA/dx);
            else
                Bx = dA/dy;
                By = - dA/dx;
                B(i_B) = sqrt(Bx^2 + By^2);
            end
            
            nodes_B(i_B, :) = [(nodes(i).x + nodes(j).x)/2, ...
                (nodes(i).y + nodes(j).y)/2];
            i_B = i_B + 1;
        end
        
    end
end

%B(B >= 1e-8) = 1e-8;

save(files.respth, 'B', 'nodes_B', '-append')
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end