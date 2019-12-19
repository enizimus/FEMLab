function clr = getColor(files, region)

load(files.respth, 'clrSett')

switch(region.specnum)
    case {1,2}
        clr = clrSett.drbColors(clrSett.drbClrInd,:);
        clrSett.drbClrInd = clrSett.drbClrInd + 1;
    case {3}
        clr = clrSett.srcColors(clrSett.srcClrInd,:);
        clrSett.srcClrInd = clrSett.srcClrInd + 1;
    case {4}
        clr = clrSett.matColors(clrSett.matClrInd,:);
        clrSett.matClrInd = clrSett.matClrInd + 1;
end

save(files.respth, 'clrSett', '-append')