function fileInfo = readFInfo(files)

if(exist(files.finfo, 'file') ~= 2)
    fileInfo = struct();
    fileInfo.date = '';
    fileInfo.setDate = '';
else
    load(files.finfo, 'fileInfo');
end