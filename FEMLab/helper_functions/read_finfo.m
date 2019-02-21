function f_info = read_finfo(files)

if(exist(files.finfo, 'file') ~= 2)
    f_info = struct();
    f_info.date = '';
    f_info.date_set = '';
else
    load(files.finfo, 'f_info');
end