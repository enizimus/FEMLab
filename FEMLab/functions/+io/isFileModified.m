function fileModified = isFileModified(files, savedDate, opt)

fileModified = false;

switch(opt)
    
    case 'MSH'
    fileDir = dir(files.mshFile);
    fileDate = fileDir.date;
    
    case 'REG'
    fileDir = dir(files.regfile);
    fileDate = fileDir.date;

end

if(isempty(fileDate))
    
    error(['No ' opt ' file present!!!'])
   
elseif(~strcmp(fileDate, savedDate))

    fileModified = true;
    io.generateFInfo(files, opt);

end