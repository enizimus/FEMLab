function fileModified = isFileModified(files, savedDate, opt)

fileModified = false;

switch(opt)
    
    case 'MSH'
    fileDate = dir(files.mshFile).date;
    
    case 'REG'
    fileDate = dir(files.regfile).date;

end

if(isempty(fileDate))
    
    error(['No ' opt ' file present!!!'])
   
elseif(~strcmp(fileDate, savedDate))

    fileModified = true;
    io.generateFInfo(files, opt);

end