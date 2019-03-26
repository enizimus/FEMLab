function [x,y] = get_non_rep(x, y)

M = [x', y'];
len = length(x);
for ip = 1:len
    I = x == x(ip) & y == y(ip);
    I(1) = false;
    I(ip) = false;
    I(end) = false;
    x(I) = [];
    y(I) = [];
    len = len - sum(I);
    if(ip == len)
        break;
    end
end