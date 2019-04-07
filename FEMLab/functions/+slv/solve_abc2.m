function ABC = solve_abc2(x,y)

ABC = zeros(3,3);
nmat = [ones(3,1), x', y'];
b = eye(3);
for i_n = 1:3
    ABC(:,i_n) = nmat\b(:,i_n);
end