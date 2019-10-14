function [I_l, I_t] = sep_lines_tris(nItems, elemsRegion, regKeys, nTris, nLines)

I_l = false(nLines, nItems(1));
I_t = false(nTris, nItems(2));

for iReg = 1:nItems(1)
    I_l(:, iReg) = elemsRegion(1:nLines) == regKeys(iReg);
end

for iReg = nItems(1)+1:sum(nItems)
    I_t(:, iReg) = elemsRegion(nLines+1:nLines+nTris) == regKeys(iReg);
end
    