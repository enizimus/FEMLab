function [matK, vecR, iN] = calcElementMats(U, hFunQuadK, hFunQuadR, hFunElemK, hFunElemR, hSideFun1, hSideFun2, hSideFun3, A, abc, xe, ye, k1, srcParams, iElem, I, nElemNodes, neuLines, lines)

f = srcParams(iElem);

iK = find(I ~= 0);
iN = 1:nElemNodes;
iN(iK) = [];
if(isempty(iK)), iK = 1; end

k = [k1 k1];

matK = zeros(nElemNodes, nElemNodes);
Rp = zeros(nElemNodes, 1);

Rneumann = zeros(nElemNodes, 1);
if(neuLines(1) && srcParams(neuLines(1)))
    neumannVal = slv.integrateNeumann(A, abc(:,1), srcParams(neuLines(1)), hSideFun1, xe, ye, 1);
    Rneumann([1,2]) = neumannVal;
end
if(neuLines(2) && srcParams(neuLines(2)))
    neumannVal = slv.integrateNeumann(A, abc(:,2), srcParams(neuLines(2)), hSideFun2, xe, ye, 2);
    Rneumann([2,3]) = neumannVal;
end
if(neuLines(3) && srcParams(neuLines(3)))
    neumannVal = slv.integrateNeumann(A, abc(:,3), srcParams(neuLines(3)), hSideFun3, xe, ye, 3);
    Rneumann([1,3]) = neumannVal;
end

for i=1:nElemNodes
    for j=i:nElemNodes
        matK(i,j) = hFunQuadK(A, k, abc, hFunElemK, xe, ye, i, j);
        matK(j,i) = matK(i,j);
    end
    Rp(i) = hFunQuadR(A, abc(:,i), f, hFunElemR, xe, ye);
end

Rp = Rp + Rneumann;

tempR = zeros(nElemNodes,1);
tempR(iN) = matK(iN, iK)*U(iK);
vecR = Rp - tempR;