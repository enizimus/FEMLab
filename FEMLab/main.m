clearvars
clc
close all

addpath('functions')

files = io.parse_gmesh();

[prob_opt, msh_opt] = io.problem_info_ui(files);

if(1)%files.f_changed)
    
    msh.prep_field_data(files, msh_opt)
    slv.calc_A(files, prob_opt)
    slv.eval_A(files)
    
    if(strcmp(prob_opt.class, 'Mstatic'))
        fem.calc_B(files, prob_opt, msh_opt)
        slv.eval_B(files)
    else
        slv.calc_E(files)
    end
end

% gfx.display(files, prob_opt, 'MSH', 'saveplot', true)
gfx.display(files, prob_opt, prob_opt.class(1), 'type', 'quiv', 'fieldLinesOn', false)
gfx.display(files, prob_opt, prob_opt.class(1), 'type','abs')

% % for validation purpose to select circular mesh edge and circular source
% % % region in the coil examples
% vld.compare_solutions(files, 1000, prob_opt, msh_opt, 1)