function [matParams, srcParams] = getElemParams(settings, elemsRegion, regSet, const)

matParams = zeros(size(elemsRegion));
srcParams = zeros(size(elemsRegion));

nRegions = length(regSet);

for iReg = 1:nRegions
    I = elemsRegion == regSet(iReg).id;
    matParams(I) = regSet(iReg).matProp;
    srcParams(I) = regSet(iReg).srcProp;
end

switch(lower(settings.problemClass))
    case {'electrostatic'}
        k_0 = const.eps_0;
        matParams = matParams*k_0; % = eps
    %case {'stationary current'}
        
    case {'magnetostatic'}
        I = matParams ~= 0;
        k_0 = const.mu_0;
        matParams(I) = 1./(matParams(I)*k_0); % = 1/mu
end



