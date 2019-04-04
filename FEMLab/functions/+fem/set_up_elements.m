function set_up_elements(files, prob_opt)

disp('-Calculating element matrices ...')
tic

load(files.respth, 'elements', 'regions_c', 'n_nodes', 'n_elements',...
    'nodes', 'nodes_prop', 'element_r', 'n_tri', 'n_lines', 'triangles', 'x', 'y')

[f_K, f_R] = slv.get_element_fun(prob_opt);
[fun_K, fun_R] = slv.get_integral_fun(prob_opt);
[a,b,c] = slv.get_abc_fun();
[tri_x, tri_y] = msh.get_tri_xy(triangles, x, y, n_tri);
tri_area = util.calc_tri_area(tri_x, tri_y, n_tri);
ABCs = slv.calc_abcs(tri_x, tri_y, n_tri, a, b, c);
[params, is_source] = msh.get_elem_params(element_r, regions_c);
        
for i_el = n_lines+1:n_elements
    i_tri = i_el-n_lines;
    abc = reshape(ABCs(i_tri,:,:), [3,3]);
    [elements(i_el).K, elements(i_el).R, elements(i_el).U, ...
        elements(i_el).n] = ...
        slv.calc_element_RK(fun_K, fun_R, f_K, f_R, nodes, ...
        nodes_prop, elements(i_el), ...
        regions_c, element_r(i_el), tri_area(i_tri),abc,...
        tri_x(i_tri,:), tri_y(i_tri,:), params(i_el), is_source(i_el));
end

save(files.respth, 'elements', 'tri_area', '-append');

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end

