function f_ch = file_changed(files, f_info)

f_ch = 0;
mfile = dir(files.mesh_file);
if(~strcmp(mfile.date, f_info.date))
    f_ch = 1;
end