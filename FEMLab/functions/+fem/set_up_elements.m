function set_up_elements(files, prob_opt)

disp('-Calculating element matrices ...')
tic

load(files.respth, 'elements', 'regions_c', 'n_nodes', 'n_elements',...
    'nodes', 'nodes_prop', 'element_r', 'n_tri', 'n_lines')

[f_K, f_R] = slv.get_element_fun(prob_opt);
[fun_K, fun_R] = slv.get_integral_fun(prob_opt);

tri_area = zeros(n_tri,1);
        
for i_el = n_lines+1:n_elements
    [elements(i_el).K, elements(i_el).R, elements(i_el).U, ...
        elements(i_el).n, tri_area(i_el-n_lines)] = ...
        slv.calc_element_RK(fun_K, fun_R, f_K, f_R, nodes, ...
        nodes_prop, elements(i_el), ...
        regions_c, element_r(i_el));
end

save(files.respth, 'elements', 'tri_area', '-append');

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end

