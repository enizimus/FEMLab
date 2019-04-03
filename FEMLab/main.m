clearvars
clc
close all

addpath('functions')

files = io.parse_gmesh();

[prob_opt, msh_opt] = io.problem_info_ui();

if(1) %files.f_changed)
    fem.set_up_elements(files, prob_opt)
    fem.assemble(files)
    fem.calc_B(files, prob_opt, msh_opt)
end

gfx.display_mesh(files, 1)
gfx.display_potentials(files, 1)
gfx.display_B(files, prob_opt, 1)

% for validation purpose to select circular mesh edge and circular source
% % region in the coil examples
vld.compare_solutions(files, 100, prob_opt, msh_opt, 1)