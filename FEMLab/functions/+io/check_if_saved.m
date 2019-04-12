function saved = check_if_saved(files, vars_list)

saved_vars = who('-file', files.respth);
saved = all(ismember(vars_list, saved_vars));