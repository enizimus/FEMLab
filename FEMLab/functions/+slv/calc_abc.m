function abc = calc_abc(x,y,a,b,c)
p1 = [x(1) y(1)];
p2 = [x(2) y(2)];
p3 = [x(3) y(3)];
abc = [a(p2,p3), a(p3,p1), a(p1,p2);
    b(p2,p3), b(p3,p1), b(p1,p2);
    c(p2,p3), c(p3,p1), c(p1,p2)];

