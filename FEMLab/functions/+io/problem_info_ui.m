function [prob_opt, msh_opt] = problem_info_ui(files)

vars_list = {'prob_opt', 'msh_opt'};
if(files.f_changed | ~io.check_if_saved(files, vars_list))
    prompt = {'Problem class', 'Problem type : ','Calculation type : ', 'Validation problem : ', 'Mesh boundary : ', 'Source type : '};
    dlgtitle = 'coil.msh options';
    dims = [1 35];
    definput = {'Estatic', 'axssym', 'int', 'dsad', 'rect', 'rect'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    prob_opt.class = answer{1};
    prob_opt.type = answer{2};
    prob_opt.int = strcmp(answer{3}, 'int');
    prob_opt.valid = answer{4};
    msh_opt.edge = answer{5};
    msh_opt.src =  answer{6};
    
    save(files.respth, 'prob_opt', 'msh_opt', '-append')
else
    load(files.respth, 'prob_opt', 'msh_opt')
end
