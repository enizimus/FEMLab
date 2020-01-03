function readRegionsFile(files)

regDate = io.readFInfo(files, 'REG');
files.filesModified = io.isFileModified(files, regDate, 'REG');

if(files.filesModified)
    
    disp('-Parsing regions file ...')
    tic
    
    io.parseRegions(files);
    
else
    
    disp('-Regions file not changed since last parse')
    tic

end

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])