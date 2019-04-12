function [prob_opt, msh_opt] = problem_info_ui(files)

vars_list = {'prob_opt', 'msh_opt'};
if(files.f_changed | ~io.check_if_saved(files, vars_list))
    prompt = {'Problem type : ','Calculation type : ', 'Validation problem : ', 'Mesh boundary : ', 'Source type : '};
    dlgtitle = 'coil.msh options';
    dims = [1 35];
    definput = {'axssym', 'int', 'dsad', 'rect', 'rect'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    prob_opt.type = answer{1};
    prob_opt.int = strcmp(answer{2}, 'int');
    prob_opt.valid = answer{3};
    msh_opt.edge = answer{4};
    msh_opt.src =  answer{5};
    
    save(files.respth, 'prob_opt', 'msh_opt', '-append')
else
    load(files.respth, 'prob_opt', 'msh_opt')
end
