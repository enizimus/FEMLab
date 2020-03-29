function l = getNeumannLines(l1, l2, lines)
l = 0;
I = all(l1 == lines, 2) | all(l2 == lines, 2);

if(any(I))
    l = find(I);
end