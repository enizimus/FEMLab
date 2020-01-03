function generateFInfo(files, opt)

switch(opt)
    
    case 'MSH'
        
        infoMsh = dir(files.mshFile);
        mshDate = infoMsh.date;
        save(files.finfo, 'mshDate', '-append')
        
    case 'REG'
        
        infoReg = dir(files.regfile);
        regDate = infoReg.date;
        save(files.finfo, 'regDate', '-append')
end
