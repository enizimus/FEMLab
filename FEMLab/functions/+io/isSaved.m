function saved = isSaved(files, varList)

varsSaved = who('-file', files.respth);
saved = all(ismember(varList, varsSaved));