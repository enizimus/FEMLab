function [matK, vecR, n] = calcElementMats(U, hFunQuadK, hFunQuadR, hFunElemK, hFunElemR, A, abc, xe, ye, k1, f, I, nElemNodes)

iK = find(I ~= 0);
iN = 1:nElemNodes;
iN(iK) = [];
if(isempty(iK)), iK = 1; end

k = [k1 k1];

matK = zeros(nElemNodes,nElemNodes);
Rp = zeros(nElemNodes, 1);

for i=1:nElemNodes
    for j=i:nElemNodes
        matK(i,j) = hFunQuadK(A, k, abc, hFunElemK, xe, ye, i, j);
        matK(j,i) = matK(i,j);
    end
    Rp(i) = hFunQuadR(A, abc(:,i), f, hFunElemR, xe, ye);
end

lenK = max([length(iK), length(iN)]);

tempR = zeros(nElemNodes,1);
tempR(iN) = U(iK)'*reshape(matK(iN, iK),[lenK, 1]);
vecR = Rp - tempR;
n = iN;



