function det_J = calcDetJ(x,y)

det_J = abs(x(1)*(y(2)-y(3))+x(2)*(y(3)-y(1))+x(3)*(y(1)-y(2)));