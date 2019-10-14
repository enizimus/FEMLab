function [regions, subsTags] = separateRegions(regions)

dimDirichlet = 1;
dimNeumann = 2;
dimSource = 3;
dimOthers = 4;

subsTags = zeros(4, size(regions,2));

ind = contains({regions.name}, 'dirichlet');
[regions(ind).dim] = deal(dimDirichlet);
subsTags(dimDirichlet, ind) = [regions(ind).tag];
iOth = ind;
ind = contains({regions.name}, 'neumann');
[regions(ind).dim] = deal(dimNeumann);
subsTags(dimNeumann, ind) = [regions(ind).tag];
iOth = iOth | ind;
ind = contains({regions.name}, 'source');
[regions(ind).dim] = deal(dimSource);
subsTags(dimSource, ind) = [regions(ind).tag];
iOth = ~(iOth | ind);
[regions(iOth).dim] = deal(dimOthers);
subsTags(dimOthers, iOth) = [regions(iOth).tag];