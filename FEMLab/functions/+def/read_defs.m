function read_defs()
defs = containers.Map('KeyType', 'char', 'ValueType', 'any'); 
file_name = './functions/+def/const_defs.dat';
c_text = io.read_file(file_name);
for k = 1:numel(c_text)
    tline = c_text{k};
    c_set = strsplit(tline, '::');
    c_set = cellfun(@strtrim,c_set,'Uni',0);
    defs(c_set{1}) = c_set{2};
end

save('./functions/+def/const_defs', 'defs')
end 