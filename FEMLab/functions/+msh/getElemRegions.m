function [elemsRegion, elemTags] = getElemRegions(elements, nElems, regSet)
% Maps the region spec to the elements instead of keeping the id's given by
% the gmesh software;

elemsRegion = reshape([elements.tags], [2, nElems])';
elemsRegion(:,2) = [];
nRegions = length(regSet);

bRegions = false(nElems, 4); % because 4 possible specs !

for iReg = 1:nRegions   
    specnum = regSet(iReg).specnum;
    bRegions(:,specnum) = bRegions(:,specnum) | elemsRegion == regSet(iReg).id;
end

elemTags = zeros(nElems, 1);
for iSpec = 1:4
    elemTags(bRegions(:,iSpec)) = iSpec;
end

