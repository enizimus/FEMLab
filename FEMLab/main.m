clearvars
clc
close all

addpath('functions')

%% FIX GET FUNS TO GET RIGHT FUN FOR CALC W B

files = main.parse_gmesh();

[prob_opt, msh_opt] = hlp.problem_info_ui();

if(1) %files.f_changed)
    main.set_up_elements(files, prob_opt)
    main.assemble(files)
    main.calc_B(files, prob_opt)
end

dspl.display_mesh(files, 1)
dspl.display_potentials(files, 1)
dspl.display_B(files, prob_opt, 1)

% for validation purpose to select circular mesh edge and circular source
% region in the coil examples

vld.compare_solutions(files, 100, msh_opt)
