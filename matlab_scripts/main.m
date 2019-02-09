clearvars
clc
close all

pths = {'helper_functions', 'main_functions'};
addpath(pths{1}, pths{2});

file_name = parse_gmesh();
display_mesh(file_name,1)
