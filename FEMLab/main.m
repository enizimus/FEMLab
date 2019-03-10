clearvars
clc
close all

pths = {'helper_functions', 'classes', ...
'main_functions', 'solver_functions', ...
'validation_functions'};

addpath(pths{1}, pths{2}, pths{3}, pths{4}, ...
    pths{5});

files = parse_gmesh();
%display_mesh(files, 1)
set_up_elements(files)  
assemble(files)
display_potentials(files, 1)
calc_B(files)
display_B(files, 1)

