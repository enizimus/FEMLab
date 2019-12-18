function [keys, values, ids] = extractKvi(regSet)

n_sett = length(regSet);
keys = cell(n_sett,1);
values = zeros(n_sett,1);
ids = zeros(n_sett,1);

