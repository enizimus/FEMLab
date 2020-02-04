function abc = calcAbcSecondOrder(x,y,A)

abc = [ones(6,1), x', y', x'.^2, (x.*y)', y'.^2]\(eye(6)*2*A);