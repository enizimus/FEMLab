function ism = isMstatic(pclass)
mstatic = {'mstatic', 'Magnetostatic', 'Magstat'};
switch pclass
    case mstatic
        ism = 1;
    otherwise
        ism = 0;
end
%ism = strcmp(lower(pclass), 'mstatic');