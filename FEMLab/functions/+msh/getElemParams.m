function [matParams, srcParams] = getElemParams(optProb, elemsRegion, regSet)

matParams = zeros(size(elemsRegion));
srcParams = zeros(size(elemsRegion));

nRegions = length(regSet);

for iReg = 1:nRegions
    I = elemsRegion == regSet(iReg).id;
    matParams(I) = regSet(iReg).matProp;
    srcParams(I) = regSet(iReg).srcProp;
end

switch(lower(optProb.problemClass))
    case {'estatic'}
        k_0 = sRegions.eps_0;
        matParams = matParams*k_0; % = eps
    case {'mstatic'}
        I = matParams ~= 0;
        k_0 = sRegions.mu_0;
        matParams(I) = 1./(matParams(I)*k_0); % = 1/mu
end



