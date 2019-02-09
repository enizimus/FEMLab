function [abc, A] = calc_abc(nodes, nods)

p1 = [nodes(nods(1)).x, nodes(nods(1)).y];
p2 = [nodes(nods(2)).x, nodes(nods(2)).y];
p3 = [nodes(nods(3)).x, nodes(nods(3)).y];

A = polyarea([p1(1), p2(1), p3(1)],...
             [p1(2), p2(2), p3(2)]);

a = @(p1,p2) p1(1)*p2(2) - p1(2)*p2(1);
b = @(p1,p2) p1(2) - p2(2);
c = @(p1,p2) p2(1) - p1(1);

abc  =  [a(p2,p3), a(p3,p1), a(p1,p2);
         b(p2,p3), b(p3,p1), b(p1,p2);
         c(p2,p3), c(p3,p1), c(p1,p2)];

    