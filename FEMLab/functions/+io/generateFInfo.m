function generateFInfo(files)

fileInfo = dir(files.mshFile);
infoSet = dir(files.settxtfile);

if(isempty(infoSet))
    error('No setting file found')
else
    
    if(isempty(fileInfo))
        fileInfo = struct();
    end
    
    fileInfo.setDate = infoSet.date;
    save(files.finfo, 'fileInfo')
end