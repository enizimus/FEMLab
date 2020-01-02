function info = readFInfo(files, opt)

if(exist(files.finfo, 'file') ~= 2)
    
    mshDate = '';
    regDate = '';
    info = '';
    
    save(files.finfo, 'mshDate', 'regDate')
    
else
    
    switch(opt)
        
        case 'MSH'
            load(files.finfo, 'mshDate');
            info = mshDate;
        case 'REG'
            load(files.finfo, 'regDate');
            info = regDate;
    end
    
end