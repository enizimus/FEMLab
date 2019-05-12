clearvars
clc
close all

addpath('functions')

files = io.parse_gmesh();

[prob_opt, msh_opt] = io.problem_info_ui(files);

if(files.f_changed)
    
    msh.prep_field_data(files, msh_opt)
    slv.calc_A(files, prob_opt)
    slv.eval_A(files)
    
    if(strcmp(prob_opt.class, 'Mstatic'))
        slv.calc_B(files, prob_opt)
    else
        slv.calc_E(files, prob_opt)
    end
    
end

field = 'E';
if(strcmp(prob_opt.class, 'Mstatic'))
    field = 'B';
end

slv.calc_W(files, prob_opt, 1:4)

gfx.display(files, prob_opt, 'MSH', 'saveplot', true)
gfx.display(files, prob_opt, 'B', 'type', 'quiv', 'saveplot', true, 'axeson', false, 'format', '-depsc')
gfx.display(files, prob_opt, 'B', 'type', 'abstri', 'saveplot', true)
gfx.display(files, prob_opt, 'B', 'type', 'abs', 'saveplot', true)
gfx.display(files, prob_opt, 'A', 'type', 'abstri', 'saveplot', true)
gfx.display(files, prob_opt, 'A', 'type', 'abs', 'saveplot', true)


% for validation purpose to select circular mesh edge and circular source
% region in the coil examples
% vld.compare_solutions(file s, 1000, prob_opt, msh_opt, 1)