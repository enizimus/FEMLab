function abc = calcAbc(x,y,A)

abc = [ones(3,1), x', y']^-1*eye(3)*2*A;