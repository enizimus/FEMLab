clearvars
clc
close all

add_fun_paths()

files = parse_gmesh();

if(files.f_changed)
    set_up_elements(files)
    assemble(files)
    calc_B(files)
end

%display_mesh(files, 1)
display_potentials(files)
display_B(files, {'quiv', 'abs'})
compare_solutions(files, 100, 'circ')
