function ise = isEstatic(pclass)
estatic = {'estatic', 'Electrostatic', 'Elstat'};
switch pclass
    case estatic
        ise = 1;
    otherwise
        ise = 0;
end