function field = getField(typeProblm)

if(strcmp(lower(typeProblm), 'mstatic'))
    field = 'B';
elseif(strcmp(lower(typeProblm), 'estatic'))
    field = 'E';
end