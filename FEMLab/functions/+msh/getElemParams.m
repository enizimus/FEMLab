function [paramsElem, paramsSour] = getElemParams(optProb, elemsRegion, sRegions)

paramsElem = zeros(size(elemsRegion));
paramsSour = zeros(size(elemsRegion));
isSource = false(size(elemsRegion));
isDir = false(size(elemsRegion));

keysDir = sRegions.codesDir;
keysSour = sRegions.getKeysSour();
keysArr = sRegions.getKeysReg('num');
keysParam = sRegions.getParamsReg(keysArr);
nReg = length(keysArr);
nSour = length(keysSour);
nDir = length(keysDir);

for iSour = 1:nSour
    isSource(elemsRegion == keysSour(iSour)) = true;
end
for iDir = 1:nDir
    isDir(elemsRegion == keysDir(iDir)) = true;
end
for iReg = 1:nReg
    I = elemsRegion == keysArr(iReg);
    paramsElem(I) = keysParam(iReg);
end

paramsSour(isSource) = paramsElem(isSource);
paramsElem(isSource) = 1;
I = ~(isDir);

switch(lower(optProb.class))
    case {'estatic'}
        k_0 = sRegions.eps_0;
        paramsElem(I) = paramsElem(I)*k_0; % = eps
    case {'mstatic'}
        k_0 = sRegions.mu_0;
        paramsElem(I) = 1./(paramsElem(I)*k_0); % = 1/mu
end



