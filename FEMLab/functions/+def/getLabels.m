function labels = getLabels(optProb)
labels = struct();
type = def.getProbType(optProb.symmetry);
switch(type)
    case(1)
        labels.x = 'x';
        labels.y = 'y';
    case(2)
        labels.x = 'r';
        labels.y = 'z';
end