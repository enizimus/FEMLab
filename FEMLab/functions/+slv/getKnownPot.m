function PotKnown = getKnownPot(bKnownPot, sRegions)
% will be expanded for case where we have multiple dirichlet boundary
% conditions so that U_know gets updated with them accordingly
bKnownPot = double(bKnownPot);
n_known = nnz(bKnownPot);
PotKnown = ones(n_known,1).*sRegions.getParam(nonzeros(bKnownPot));

end