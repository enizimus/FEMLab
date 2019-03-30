function c_text = read_file(file_name)
fid = fopen(file_name,'r');
k = 0;
while true
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    k = k + 1;
    c_text{k} = tline;
end
fclose(fid);
end 