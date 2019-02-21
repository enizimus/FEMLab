function f_ch = file_changed(files, f_info)

f_ch = 0;
mfile = dir(files.mesh_file);
setfile = dir(files.setfile);
if(~strcmp(mfile.date, f_info.date) || ...
   ~strcmp(setfile.date, f_info.date_set))
    f_ch = 1;
end