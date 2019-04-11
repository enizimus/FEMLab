function files = generate_files(file_path, file_name)

files = struct();

files.file_name = file_name;
files.file_path = file_path;
files.mesh_file = [file_path, file_name, '.msh'];
files.results = [file_path, 'results\']; 
files.finfo = [files.results, 'finfo.mat'];
files.setfile = [file_path, 'settings.txt'];
files.respth = [files.results, file_name];
files.pltpth = [file_path, 'plots\'];
files.pltpth_mesh = [files.pltpth, file_name, '_mesh'];
files.pltpth_pot = [files.pltpth, file_name, '_potential'];
files.pltpth_absB = [files.pltpth, file_name, '_absB'];
files.pltpth_quivB = [files.pltpth, file_name, '_quivB'];
files.pltpth_contB = [files.pltpth, file_name, '_contB'];
files.pltpth_sliceB = [files.pltpth, file_name, '_sliceB'];
files.pltpth_absA = [files.pltpth, file_name, '_absA'];
files.pltpth_quivA = [files.pltpth, file_name, '_quivA'];
files.pltpth_contA = [files.pltpth, file_name, '_contA'];
files.pltpth_sliceA = [files.pltpth, file_name, '_sliceA'];
files.pltpth_valid1 = [files.pltpth, file_name, '_validation_comp'];
files.pltpth_valid2 = [files.pltpth, file_name, '_validation_error'];
files.f_changed = 1;

if(exist(files.pltpth, 'dir') ~= 7)
        mkdir(files.pltpth)
end

if(exist(files.results, 'dir') ~= 7)
    mkdir(files.results)
end