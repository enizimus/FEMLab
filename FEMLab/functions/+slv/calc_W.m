function calc_W(files, prob_opt, region)

field_str = [prob_opt.field, 'c'];

load(files.respth, field_str, 'elements', 'n_lines', 'regions_c', ...
    'element_r', 'tri_area', 'triangles')

X = eval(field_str);
[elem_params, ~] = msh.get_elem_params(prob_opt, element_r, regions_c);

region_index = false(size(element_r));
for i_reg = 1:length(region)
    temp_index = element_r == region(i_reg);
    region_index = region_index | temp_index;
end

region_index = region_index(n_lines+1:end);
elem_params = elem_params(n_lines+1:end);
n_elems = length(region_index);

if(def.is_planar(prob_opt.type))
    W = 0.5*elem_params(region_index)'.*X(region_index).^2*tri_area(region_index);
else
    region_index = find(region_index);
    load(files.respth, 'x', 'y')
    int_W = slv.get_funs('Wint');
    fun_W = slv.get_funs('W');
    W = 0;
    for i_index = 1:length(region_index)
        i_elem = region_index(i_index);
        W = W + int_W(X(i_elem), tri_area(i_elem), elem_params(i_elem), x(triangles(i_elem,:)), fun_W);
    end
    W = W*2*pi;
end
disp(['W = ' num2str(W)])

% R = 0.001;
% A_sour = R^2*pi;
% J = regions_c.get_param('source');
% I = A_sour*J;
% L = 2*W/(I^2);
% disp(['L = ' num2str(L)])

save(files.respth, 'W', '-append')


