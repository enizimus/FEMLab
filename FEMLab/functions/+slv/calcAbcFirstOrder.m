function abc = calcAbcFirstOrder(x,y,A)

abc = [ones(3,1), x, y]\(eye(3)*2*A);