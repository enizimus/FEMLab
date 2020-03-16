function xy = readLinePointsFile(filePath)
xy = [];
fid = fopen(filePath, 'r');
line = strsplit(fgetl(fid));
line = strsplit(fgetl(fid));
while(length(line) > 1)
    xy = [xy; [str2double(line{1}),str2double(line{3})]];
    
    try
        line = strsplit(fgetl(fid));
    catch 
        break
    end
end

fclose(fid);