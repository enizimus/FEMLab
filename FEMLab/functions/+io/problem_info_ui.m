function [optProb, mshType] = problem_info_ui(files)

vars_list = {'optProb', 'mshType'};
if(files.f_changed | ~io.check_if_saved(files, vars_list))
    prompt = {'Problem class', 'Problem type : ','Calculation type : ', 'Validation problem : ', 'Mesh boundary : ', 'Source type : '};
    dlgtitle = 'coil.msh options';
    dims = [1 35];
    definput = {'Estatic', 'axssym', 'int', 'dsad', 'rect', 'rect'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    optProb.class = answer{1};
    optProb.type = answer{2};
    optProb.int = strcmp(answer{3}, 'int');
    optProb.valid = answer{4};
    mshType.edge = answer{5};
    mshType.src =  answer{6};
    
    save(files.respth, 'optProb', 'mshType', '-append')
else
    load(files.respth, 'optProb', 'mshType')
end
