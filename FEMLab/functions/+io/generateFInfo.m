function generateFInfo(files)

fileInfo = dir(files.mshFile);
infoSet = dir(files.settxtfile);

if(isempty(fileInfo))
    fileInfo = struct();
end

fileInfo.setDate = '';
save(files.finfo, 'fileInfo')
