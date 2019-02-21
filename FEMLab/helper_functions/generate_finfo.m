function generate_finfo(files)

f_info = dir(files.mesh_file);
save(files.finfo, 'f_info')