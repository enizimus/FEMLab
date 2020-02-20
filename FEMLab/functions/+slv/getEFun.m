function [hFunEx, hFunEy] = getEFun(optProb)

hFunEx = @(A, ABC) -ABC(2,:)*A;
hFunEy = @(A, ABC, ~, ~) -ABC(3,:)*A;
