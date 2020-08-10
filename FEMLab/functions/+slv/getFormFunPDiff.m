function f = getFormFunPDiff(optProb)
% \brief Get a function handle formcalculating the partial derivative of
%        the triangle-formfunctions.
%
% \details The partial derivatives have a polynomial-degree of one lower
%          than the formfunciton iself.
%          E.g. the x-partial derivative of a second-order formfunction is
%          is of form 
%               f(x, y) = a0 + a1 * x + a2 * y
%
%          In isoparametric-domain the coefficients are constant for all
%          triangles. They are defined in getAbcsPDiffXiEta().
%
%
if optProb.elementOrder == 1
    f = @(x,y,ABC) ABC;
elseif optProb.elementOrder == 2
    f = @(x,y,ABC) [1, x, y]*ABC;
end