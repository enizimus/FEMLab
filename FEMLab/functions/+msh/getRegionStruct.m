function regions = getRegionStruct(regionNames, regionIds, nRegions)

regions = struct('dim', {}, 'id', {}, 'name', {});

for i_region = nRegions:-1:1
    regions(i_region).dim = regionIds(i_region, 1);
    regions(i_region).id = regionIds(i_region, 2);
    regions(i_region).name = regionNames{i_region};
    regions(i_region).spec = 'MAT';
    regions(i_region).matProp = 0;
    regions(i_region).srcProp = 0;
end