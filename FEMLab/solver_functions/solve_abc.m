function ABC = solve_abc(x,y)

ABC = zeros(3,3);
nmat = [x', y', ones(3,1)];
b = eye(3);
for i_n = 1:3
    ABC(:,i_n) = nmat\b(:,i_n);
end