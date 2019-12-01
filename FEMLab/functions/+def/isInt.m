function is_pl = isInt(type)

cases = {'Int', 'int', 'Integrate', 'Integration'};
switch type
    case cases
        is_pl = 1;
    otherwise
        is_pl = 0;
end