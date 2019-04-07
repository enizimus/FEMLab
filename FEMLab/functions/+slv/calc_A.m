function calc_A(files, prob_opt)
disp('-Setting up element matrices and calculating A')
tic

load(files.respth, 'elements', 'regions_c', 'n_nodes', 'n_elements',...
    'nodes_prop', 'element_r', 'n_tri', 'n_lines', 'triangles', 'x', 'y')

[f_K, f_R] = slv.get_element_fun(prob_opt);
[fun_K, fun_R] = slv.get_integral_fun(prob_opt);
[a,b,c] = slv.get_abc_fun();
[tri_x, tri_y] = msh.get_tri_xy(triangles, x, y, n_tri);
tri_area = util.calc_tri_area(tri_x, tri_y, n_tri);
ABCs = slv.calc_abcs(tri_x, tri_y, n_tri, a, b, c);
[params, is_source] = msh.get_elem_params(element_r, regions_c);
elems = reshape([elements(n_lines+1:end).nodes], [3 n_elements-n_lines])';
[Uk, Ik] = slv.setup_known_U(elems, n_tri, nodes_prop, regions_c);

K = spalloc(n_nodes, n_nodes, 6*n_nodes);
R = zeros(n_nodes,1);

for i_el = n_lines+1:n_elements
    i_tri = i_el-n_lines;
    abc = reshape(ABCs(i_tri,:,:), [3,3]);

    [tK, tR, tU, tn] = ...
        slv.calc_element_RK(Uk(i_tri,:)', fun_K, fun_R, f_K, f_R, tri_area(i_tri),abc,...
        tri_x(i_tri,:), tri_y(i_tri,:), params(i_el), is_source(i_el), Ik(i_tri,:));
    
    i_N = elements(i_el).nodes(tn);
    
    K(i_N, i_N) = K(i_N, i_N) + tK(tn, tn);
    R(i_N) = R(i_N) + tR(tn);
    
    elements(i_el).K = tK(tn, tn);
    elements(i_el).R = tR(tn);
    elements(i_el).U = tU;
    
end

U = zeros(n_nodes, 1);

I = any(K,2);
u_unknown = I;
u_known = ~I;
K = K(I,:);
R = R(I);
I = any(K,1);
K = K(:,I);

U_known = slv.get_known_U(u_known, regions_c);
U_unknown = K\R;
U(u_unknown) = U_unknown;
U(u_known) = U_known;

save(files.respth, 'elements', 'U', 'K', 'R', 'tri_area', '-append');
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end