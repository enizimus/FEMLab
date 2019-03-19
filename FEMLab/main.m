clearvars
clc
close all

add_fun_paths()

files = parse_gmesh();

if(1) %files.f_changed
    set_up_elements(files, 'integrate')
    assemble(files)
    calc_B(files)
end

%display_mesh(files, 1)
display_potentials(files, 1)
display_B(files, {'quiv', 'abs'})

% for validation purpose to select circular mesh edge and circular source
% region in the coil examples
msh_opt = struct('edge', {'circ'}, 'src', {'circ'}); 
compare_solutions(files, 100, msh_opt)
