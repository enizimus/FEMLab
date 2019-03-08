function calc_B(files)

disp('-Calculating magnetic field ...')
tic
load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes')

n_tri = length(triangles);
B = zeros(1,n_tri);
nodes_B = zeros(n_tri, 2);

for i_tri = 1:n_tri
    x = [nodes(triangles(i_tri,:)).x];
    y = [nodes(triangles(i_tri,:)).y];
    ABC = solve_abc(x,y);
    
    By = -(U(triangles(i_tri,:))'*ABC(1,:)');
    Bx = U(triangles(i_tri,:))'*ABC(2,:)';
    
    B(i_tri) = sqrt(Bx^2 + By^2);
    nodes_B(i_tri, :) = [sum(x)/3, sum(y)/3];
end

save(files.respth, 'B', 'nodes_B', '-append')
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])

end