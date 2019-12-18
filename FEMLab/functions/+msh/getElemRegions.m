function elemsRegion = getElemRegions(elements, nElems, regSet)
% Maps the region spec to the elements instead of keeping the id's given by
% the gmesh software;

elemsRegion = reshape([elements.tags], [2, nElems])';
elemsRegion(:,2) = [];
nRegions = length(regSet);

bRegions = false(nElems, nRegions);

for iReg = 1:nRegions
    bRegions(:,iReg) = elemsRegion == regSet(iReg).id;
end
    
for iReg = 1:nRegions
    elemsRegion(bRegions(:,iReg)) = regSet(iReg).specnum;
end

