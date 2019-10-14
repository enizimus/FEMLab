function defRead()
defs = containers.Map('KeyType', 'char', 'ValueType', 'any'); 
fileName = './functions/+def/const_defs.dat';
cText = io.readFile(fileName);
for k = 1:numel(cText)
    tline = cText{k};
    cSet = strsplit(tline, '::');
    cSet = cellfun(@strtrim,cSet,'Uni',0);
    defs(cSet{1}) = cSet{2};
end

save('./functions/+def/const_defs', 'defs')
end 