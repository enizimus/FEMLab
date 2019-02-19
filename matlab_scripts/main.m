clearvars
clc
close all

pths = {'helper_functions', 'classes', ...
'main_functions', 'solver_functions'};

addpath(pths{1}, pths{2}, pths{3}, pths{4});

file_name = parse_gmesh();
display_mesh(file_name,1)
set_up_elements(file_name)
assemble(file_name)