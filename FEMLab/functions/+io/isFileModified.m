function fileMod = isFileModified(files, fileInfo)

fileMod = false;
mfile = dir(files.mshFile);
setfile = dir(files.setfile);
if isempty(mfile) || isempty(setfile)
    fileMod = true;
   
elseif(~strcmp(mfile.date, fileInfo.date) || ...
   ~strcmp(setfile.date, fileInfo.setDate))
    fileMod = true;

end