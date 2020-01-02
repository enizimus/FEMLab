function files = readMeshFile(files, elemOrder)

mshDate = io.readFInfo(files, 'MSH');
files.filesModified = io.isFileModified(files, mshDate, 'MSH');

form = io.getElemFormSpec(elemOrder);

if(files.filesModified)
    
    disp('-Parsing mesh file ...')
    tic
    
    io.parseGmesh(files, form)
    
else
    
    disp('-Mesh file not changed since last parse')
    tic

end

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
save(files.respth, 'form', '-append')