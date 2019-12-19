function potKnown = getKnownPot(bKnownPot, prescNodes, regSet)
% will be expanded for case where we have multiple dirichlet boundary
% conditions so that U_know gets updated with them accordingly

potKnown = prescNodes(bKnownPot);
keys = unique(potKnown);
nKeys = length(keys);

bSet = false(length(potKnown), nKeys);
vals = zeros(nKeys, 1);

for ind = 1:nKeys
    bSet(:,ind) = potKnown == keys(ind);
    vals(ind) = regSet(keys(ind)).srcProp;
end

for ind = 1:nKeys
    potKnown(bSet(:,ind)) = vals(ind);
end