function initConfigParams(files)

load(files.respth, 'regions')

if(~(exist(files.regfile, 'file')==2))
    % Initializes a regions setup file with current regions from mesh file 
    io.generateRegionsFile(files, regions);
end

end