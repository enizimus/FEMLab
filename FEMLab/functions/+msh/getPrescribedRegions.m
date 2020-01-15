function prescRegions = getPrescribedRegions(regSet)

specnums = [regSet(:).specnum];
prescRegsBool = specnums < 3;
prescRegions = find(prescRegsBool);