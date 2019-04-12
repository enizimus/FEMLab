clearvars
clc
close all

addpath('functions')

files = io.parse_gmesh();

[prob_opt, msh_opt] = io.problem_info_ui(files);

if(files.f_changed)
    msh.prep_field_data(files, msh_opt)
    slv.calc_A(files, prob_opt)
    fem.calc_B(files, prob_opt, msh_opt)
    slv.eval_A(files)
end

gfx.display(files, prob_opt, 'MSH', 'saveplot', true)
gfx.display(files, prob_opt, 'B', 'type', 'quiv', 'nCont', 24, 'saveplot', true)
gfx.display(files, prob_opt, 'B', 'type','abs', 'saveplot', true)

% % for validation purpose to select circular mesh edge and circular source
% % % region in the coil examples
% vld.compare_solutions(files, 1000, prob_opt, msh_opt, 1)