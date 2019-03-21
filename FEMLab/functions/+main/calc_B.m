function calc_B(files, prob_opt)

disp('-Calculating magnetic field ...')
tic
load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes')

n_tri = length(triangles);
B = zeros(1,n_tri);
Bx = zeros(1,n_tri);
By = zeros(1,n_tri);
nodes_B = zeros(n_tri, 2);

[f_Bx, f_By] = slvr.get_B_fun(prob_opt);

for i_tri = 1:n_tri
   
    x = [nodes(triangles(i_tri,:)).x];
    y = [nodes(triangles(i_tri,:)).y];
    ABC = slvr.solve_abc(x,y);
    nodes_B(i_tri, :) = [sum(x)/3, sum(y)/3];
    
    cBy = f_By(U(triangles(i_tri,:)), ABC, x, y);
    cBx = f_Bx(U(triangles(i_tri,:)), ABC);
    
    Bx(i_tri) = cBx;
    By(i_tri) = cBy;
    B(i_tri) = sqrt(cBx^2 + cBy^2);
    
end

save(files.respth, 'B', 'Bx', 'By', 'nodes_B', '-append')
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])

end