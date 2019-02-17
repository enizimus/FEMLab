clearvars
clc
close all

pths = {'helper_functions', 'classes', ...
'main_functions', 'solver_functions'};

addpath(pths{1}, pths{2}, pths{3});

file_name = parse_gmesh();
display_mesh(file_name,1)
solver(file_name)
