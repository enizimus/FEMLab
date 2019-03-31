function is_in = is_in_tri(xp, yp, x, y, epsilon)

is_in = false;

Atst =  polyarea([xp, x(1), x(2)], [yp, y(1), y(2)]) + ...
    polyarea([xp, x(2), x(3)], [yp, y(2), y(3)]) + ...
    polyarea([xp, x(3), x(1)], [yp, y(3), y(1)]);
A = polyarea(x,y);

if( abs(A - Atst) < epsilon )
    is_in = true;
end