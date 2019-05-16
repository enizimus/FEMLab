function field = get_field(prob_t)

if(strcmp(lower(prob_t), 'mstatic'))
    field = 'B';
elseif(strcmp(lower(prob_t), 'estatic'))
    field = 'E';
end