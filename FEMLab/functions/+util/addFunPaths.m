function addFunPaths()
dirs = dir(pwd);
id = [dirs(:).isdir];
dnames = {dirs(id).name};
dnames(ismember(dnames,{'.','..'})) = [];
for iPth = 1:length(dnames)
    addpath(dnames{iPth})
end

