function initConfigParams(files)

load(files.respth, 'regions')

% Definition of constants :
const = struct('mu_0', 1.2566e-06, 'eps_0', 8.854187e-12); 

% Initialize colors : 
clrSett = struct();
clrSett.matColors = [[34, 245, 154]; [92, 182, 242]; [4, 80, 130]; [24, 94, 64]; [34, 245, 154]; [92, 182, 242]; [4, 80, 130]; [24, 94, 64]; [34, 245, 154]; [92, 182, 242]; [4, 80, 130];]./255;
clrSett.srcColors = [[232, 27, 0]; [224, 101, 0]; [143, 11, 11]; [204, 41, 136]; [232, 27, 0]; [224, 101, 0]; [143, 11, 11]; [204, 41, 136]; [34, 245, 154]; [92, 182, 242]; [4, 80, 130];]./255;
clrSett.drbColors = [[250, 250, 37]; [175, 186, 19]; [24, 56, 184]; [252, 252, 177]; [250, 250, 37]; [175, 186, 19]; [24, 56, 184]; [252, 252, 177]; [34, 245, 154]; [92, 182, 242]; [4, 80, 130];]./255;
clrSett.drbClrInd = 1; clrSett.srcClrInd = 1; clrSett.matClrInd = 1;

if(~(exist(files.regfile, 'file') == 2))
    % Initializes a regions setup file with current regions from mesh file
    io.generateRegionsFile(files, regions);
end

save(files.respth, 'const', 'clrSett', '-append')

end