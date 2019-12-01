function generateFInfo(files)

fileInfo = dir(files.mshFile);
infoSet = dir(files.settxtfile);

if(isempty(infoSet))
    error('No setting file found')
else
fileInfo.setDate = infoSet.date;
save(files.finfo, 'fileInfo')
end