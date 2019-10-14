function fileMod = isFileModified(files, fileInfo)

fileMod = 0;
mfile = dir(files.mshFile);
setfile = dir(files.setfile);
if(~strcmp(mfile.date, fileInfo.date) || ...
   ~strcmp(setfile.date, fileInfo.setDate))
    fileMod = 1;
end