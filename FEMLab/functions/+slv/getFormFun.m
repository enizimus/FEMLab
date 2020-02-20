function f = getFormFun(optProb)

if optProb.elementOrder == 1
    f = @(x,y,ABC) [1, x, y]*ABC;
elseif optProb.elementOrder == 2
    f = @(x,y,ABC) [1, x, y, x^2, x*y, y^2]*ABC;
end