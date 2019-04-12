clearvars
clc
close all

addpath('functions')

files = io.parse_gmesh();

[prob_opt, msh_opt] = io.problem_info_ui();

if(1) %files.f_changed)
    msh.prep_field_data(files, msh_opt)
    slv.calc_A(files, prob_opt)
    fem.calc_B(files, prob_opt, msh_opt)
    slv.eval_A(files)
end

gfx.display(files, prob_opt, 'MSH')
gfx.display(files, prob_opt, 'B', 'quiv')
gfx.display(files, prob_opt, 'B', 'abs')

% % for validation purpose to select circular mesh edge and circular source
% % % region in the coil examples
vld.compare_solutions(files, 100, prob_opt, msh_opt, 1)