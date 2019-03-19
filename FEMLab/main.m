clearvars
clc
close all

addpath('functions')

files = main.parse_gmesh();

if(files.f_changed)
    main.set_up_elements(files, 'integrate')
    main.assemble(files)
    main.calc_B(files)
end

dspl.display_mesh(files, 1)
dspl.display_potentials(files, 1)
dspl.display_B(files, {'quiv', 'abs'})

% for validation purpose to select circular mesh edge and circular source
% region in the coil examples
msh_opt = struct('edge', {'circ'}, 'src', {'circ'}); 
vld.compare_solutions(files, 100, msh_opt)
