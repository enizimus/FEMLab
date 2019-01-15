function [line, err] = get_line(fid)
line = '';
err = 0;

try 
    line = fgetl(fid);
catch my_expt
    err = 1;
    error(my_expt);
end

end

