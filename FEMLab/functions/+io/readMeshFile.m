function files = readMeshFile(files, elemOrder, logWin)

mshDate = io.readFInfo(files, 'MSH');
files.filesModified = io.isFileModified(files, mshDate, 'MSH');

form = io.getElemFormSpec(elemOrder);

if(files.filesModified)
    
    %disp('-Parsing mesh file ...')
    logWin.Value = {logWin.Value{:}, ' - Parsing mesh file ...'};
    tic
    
    io.parseGmesh(files, form)
    
else
    
    %disp('-Mesh file not changed since last parse')
    logWin.Value = {logWin.Value{:}, ' - Mesh file not changed since last parse'};
    tic

end

log = [' - Finished (Elapsed time : ', num2str(toc) ' s)'];
logWin.Value = {logWin.Value{:}, log};

save(files.respth, 'form', '-append')