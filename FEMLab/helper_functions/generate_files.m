function files = generate_files(file_path, file_name)

files = struct();

files.file_name = file_name;
files.file_path = file_path;
files.mesh_file = [file_path, file_name, '.msh'];
files.results = [file_path, 'results\']; 
files.finfo = [files.results, 'finfo.mat'];
files.respth = [files.results, file_name];
files.pltpth = [file_path, 'plots\'];
files.pltpth_mesh = [files.pltpth, file_name, '_mesh'];
files.pltpth_pot = [files.pltpth, file_name, '_potential'];
files.pltpth_B = [files.pltpth, file_name, '_Bfield'];

if(exist(files.pltpth, 'dir') ~= 7)
        mkdir(files.pltpth)
end

if(exist(files.results, 'dir') ~= 7)
    mkdir(files.results)
end