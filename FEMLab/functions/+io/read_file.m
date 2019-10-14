function cText = read_file(fileName)
fid = fopen(fileName,'r');
k = 0;
while true
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    k = k + 1;
    cText{k} = tline;
end
fclose(fid);
end 