function [B, nodes_B] = calc_B(file_name)
disp('-Calculating magnetic field ...')
respth = ['.\results\', file_name];
load(respth, 'U', 'triangles', 'nodes', 'n_nodes')

n_tri = length(triangles);
I = adj_mat(triangles, n_tri, n_nodes);
n_nz = nnz(I);

B = zeros(n_nz,1);
nodes_B = zeros(n_nz, 2);

i_B = 1;
for i=1:n_nodes-1
    for j=i+1:n_nodes
        
        if(I(i,j))
            B(i_B) = (U(i) + U(j))/2;
            nodes_B(i_B, :) = [(nodes(i).x + nodes(j).x)/2, ...
                (nodes(i).y + nodes(j).y)/2];
            i_B = i_B + 1;
        end
        
    end
end
end