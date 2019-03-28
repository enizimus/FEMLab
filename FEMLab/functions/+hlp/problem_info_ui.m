function [prob_opt, msh_opt] = problem_info_ui()

% msh_opt = struct('edge', {'circ'}, 'src', {'circ'}); 
% prob_opt = struct('type', {'axssym'}, 'int', {1}, 'fieldplt', {{'quiv'}});

prompt = {'Problem type : ','Calculation type : ', 'Mesh boundary : ', 'Field plot :'};
dlgtitle = 'coil.msh options';
dims = [1 35];
definput = {'rotsym','int','rect','quiv'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

prob_opt.type = answer{1};
prob_opt.int = strcmp(answer{2}, 'int');
prob_opt.fieldplt = strsplit(strrep(answer{4},' ', ''), ',');
msh_opt.edge = answer{3};
msh_opt.src = 'circ';
