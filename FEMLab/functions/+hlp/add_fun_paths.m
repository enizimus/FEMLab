function add_fun_paths()
dirs = dir(pwd);
id = [dirs(:).isdir];
dnames = {dirs(id).name};
dnames(ismember(dnames,{'.','..'})) = [];
for i_d = 1:length(dnames)
    addpath(dnames{i_d})
end

