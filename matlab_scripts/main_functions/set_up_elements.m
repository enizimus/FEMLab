function set_up_elements(file_name)
%SOLVER
disp('-Calculating element matrices ...')
tic
respth = ['.\results\', file_name];
load(respth, 'elements', 'regions_c', 'n_nodes', 'n_elements',...
    'nodes', 'nodes_prop', 'element_r')

i_elem = 1;
while(elements(i_elem).type == 1)
    i_elem = i_elem + 1;
end

for i_el = i_elem:n_elements
    [elements(i_el).K, elements(i_el).R, elements(i_el).U, ...
        elements(i_el).n] = ...
        calc_element_RK(nodes, nodes_prop, elements(i_el), ...
        regions_c, element_r(i_el));
end

save(respth, 'elements', '-append');

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end

