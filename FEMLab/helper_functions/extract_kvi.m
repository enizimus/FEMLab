function [keys, values, ids] = extract_kvi(settings)

n_sett = length(settings);
keys = cell(n_sett,1);
values = zeros(n_sett,1);
ids = zeros(n_sett,1);
for i_sett = 1:n_sett
    if(settings(i_sett).sour == 0 & settings(i_sett).id ~= 1)
        values(i_sett) = str2double(settings(i_sett).reg);
    else
        values(i_sett) = settings(i_sett).sour;
    end
    keys(i_sett) = {settings(i_sett).name};
    ids(i_sett) = settings(i_sett).id;
end

