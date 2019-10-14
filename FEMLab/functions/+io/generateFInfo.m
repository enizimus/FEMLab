function generateFInfo(files)

fileInfo = dir(files.mshFile);
infoSet = dir(files.setfile);

if(isempty(infoSet))
    error('No setting file found')
else
fileInfo.setDate = infoSet.date;
save(files.finfo, 'fileInfo')
end