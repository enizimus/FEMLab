function generateLinePointsFile(filePath)

fid = fopen(filePath, 'wt');
line = 'x , y\r';
fprintf(fid, line);
line = '0 , 0\r';
fprintf(fid, line);
fclose(fid);