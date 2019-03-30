function N = get_funs(type)

switch lower(type)
    case {'formarr'}
        N = @(x,y,ABC) ABC*[x, y, 1]';
end