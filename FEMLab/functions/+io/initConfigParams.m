function initConfigParams(files)

load(files.respth, 'regions')

% Definition of constants :
const = struct('mu_0', 1.2566e-06, 'eps_0', 8.854187e-12); 

if(~(exist(files.regfile, 'file')==2))
    % Initializes a regions setup file with current regions from mesh file 
    io.generateRegionsFile(files, regions);
end

save(files.respth, 'const', '-append')

end