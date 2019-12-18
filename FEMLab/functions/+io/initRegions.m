function initRegions(files)
% Creates new regions setup file if none is present otherwise overwrites
% the one that is present.

savePath = files.regfile;

regions = struct('mu_0', 1.2566e-06, 'eps_0', 8.854187e-12, ...
    'names', {'Name1'}, 'type', [1], 'id', [1], 'materialProp', [1], ...
    'sourceProp', [1], 'matColor', [1], 'sourColor', [2], 'boundColor', [3]);

save(savePath, 'regions')