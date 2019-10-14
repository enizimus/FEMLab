function files = generate_files(file_path, fileName)

files = struct();

files.fileName = fileName;
files.file_path = file_path;
files.mesh_file = [file_path, fileName, '.msh'];
files.results = [file_path, 'results\'];
files.finfo = [files.results, 'finfo.mat'];
files.setfile = [file_path, 'settings.txt'];
files.respth = [files.results, fileName];
files.pltpth = [file_path, 'plots\'];
files.pltpth_mesh = [files.pltpth, fileName, '_mesh'];
files.pltpth_pot = [files.pltpth, fileName, '_potential'];
files.pltpth_absB = [files.pltpth, fileName, '_absB'];
files.pltpth_quivB = [files.pltpth, fileName, '_quivB'];
files.pltpth_contB = [files.pltpth, fileName, '_contB'];
files.pltpth_sliceB = [files.pltpth, fileName, '_sliceB'];
files.pltpth_abstriB = [files.pltpth, fileName, '_abstriB'];
files.pltpth_flinesB = [files.pltpth, fileName, '_flinesB'];
files.pltpth_absE = [files.pltpth, fileName, '_absE'];
files.pltpth_quivE = [files.pltpth, fileName, '_quivE'];
files.pltpth_contE = [files.pltpth, fileName, '_contE'];
files.pltpth_sliceE = [files.pltpth, fileName, '_sliceE'];
files.pltpth_abstriE = [files.pltpth, fileName, '_abstriE'];
files.pltpth_flinesE = [files.pltpth, fileName, '_flinesE'];
files.pltpth_absA = [files.pltpth, fileName, '_absA'];
files.pltpth_quivA = [files.pltpth, fileName, '_quivA'];
files.pltpth_contA = [files.pltpth, fileName, '_contA'];
files.pltpth_abstriA = [files.pltpth, fileName, '_abstriA'];
files.pltpth_valid1 = [files.pltpth, fileName, '_validation_comp'];
files.pltpth_valid2 = [files.pltpth, fileName, '_validation_error'];
files.f_changed = 1;

if(exist(files.pltpth, 'dir') ~= 7)
    mkdir(files.pltpth)
end

if(exist(files.results, 'dir') ~= 7)
    mkdir(files.results)
end