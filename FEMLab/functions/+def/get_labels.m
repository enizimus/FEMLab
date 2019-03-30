function labels = get_labels(prob_opt)
labels = struct();
type = def.get_prob_type(prob_opt.type);
switch(type)
    case(1)
        labels.x = 'x';
        labels.y = 'y';
    case(2)
        labels.x = 'r';
        labels.y = 'z';
end