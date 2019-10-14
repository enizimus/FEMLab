function [a,b,c] = getAbcFun()

a = @(p1,p2) p1(1)*p2(2) - p1(2)*p2(1);
b = @(p1,p2) p1(2) - p2(2);
c = @(p1,p2) p2(1) - p1(1);