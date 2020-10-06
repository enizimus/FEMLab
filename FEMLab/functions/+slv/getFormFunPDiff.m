function f = getFormFunPDiff(optProb)
% \brief Get a function handle for calculating the partial derivative of
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
    f = @(x,y,ABC) repmat(ABC', length(x),1);
elseif optProb.elementOrder == 2
    f = @(x,y,ABC) [ones(length(x),1), x, y]*ABC';
end