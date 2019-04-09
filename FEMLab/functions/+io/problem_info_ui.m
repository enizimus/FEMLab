function [prob_opt, msh_opt] = problem_info_ui()

% msh_opt = struct('edge', {'circ'}, 'src', {'circ'}); 
% prob_opt = struct('type', {'axssym'}, 'int', {1}, 'fieldplt', {{'quiv'}});

prompt = {'Problem type : ','Calculation type : ', 'Validation problem : ', 'Mesh boundary : ', 'Field plot :', 'Source type : '};
dlgtitle = 'coil.msh options';
dims = [1 35];
definput = {'planar', 'int', 'diag', 'rect', 'quiv', 'rect'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

prob_opt.type = answer{1};
prob_opt.int = strcmp(answer{2}, 'int');
prob_opt.fieldplt = strsplit(strrep(answer{5},' ', ''), ',');
prob_opt.valid = answer{3};
msh_opt.edge = answer{4};
msh_opt.src =  answer{6};
