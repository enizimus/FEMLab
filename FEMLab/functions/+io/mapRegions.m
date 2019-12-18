function specNum = mapRegions(spec)

% nRegions = length(regions);
%
% dirRegs = false(nRegions,1);
% neuRegs = false(nRegions,1);
% matRegs = false(nRegions,1);
% srcRegs = false(nRegions,1);


switch spec
    case 'DRB'
        specNum = 1;
    case 'NRB'
        specNum = 2;
    case 'MAT'
        specNum = 3;
    case 'SRC'
        specNum = 4;
end
