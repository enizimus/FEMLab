function ABC = solve_abc(x,y)

ABC = [x', y', ones(3,1)]^-1*eye(3);
