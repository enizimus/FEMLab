function [comb, regKeys] = getComboKeys(regSet)
nItems = length(regSet);
regKeys = [regSet.id];
comb = {regSet.name};

for iItem = 1:nItems
    comb{iItem} = [comb{iItem} ' (' num2str(regKeys(iItem)) ')'];
end

end