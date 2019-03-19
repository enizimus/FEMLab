function generate_finfo(files)

f_info = dir(files.mesh_file);
set_info = dir(files.setfile);

if(isempty(set_info))
    error('No setting file found')
else
f_info.date_set = set_info.date;
save(files.finfo, 'f_info')
end