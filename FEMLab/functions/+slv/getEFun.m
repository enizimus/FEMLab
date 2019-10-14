function [hFunEx, hFunEy] = getEFun(optProb)

hFunEx = @(A, ABC) -A'*ABC(1,:)';
hFunEy = @(A, ABC, ~, ~) -A'*ABC(2,:)';
