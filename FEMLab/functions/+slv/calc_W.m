function calc_W(files, optProb, region)

field_str = [optProb.field, 'c'];

load(files.respth, field_str, 'elements', 'nLines', 'sRegions', ...
    'elemsRegion', 'tri_area', 'triangles')

X = eval(field_str);
[paramsElem, ~] = msh.getElemParams(optProb, elemsRegion, sRegions);

region_index = false(size(elemsRegion));
for iReg = 1:length(region)
    temp_index = elemsRegion == region(iReg);
    region_index = region_index | temp_index;
end

region_index = region_index(nLines+1:end);
paramsElem = paramsElem(nLines+1:end);
n_elems = length(region_index);

if(def.isPlanar(optProb.type))
    W = 0.5*paramsElem(region_index)'.*X(region_index).^2*tri_area(region_index);
else
    region_index = find(region_index);
    load(files.respth, 'x', 'y')
    int_W = slv.get_funs('Wint');
    fun_W = slv.get_funs('W');
    W = 0;
    for i_index = 1:length(region_index)
        iElem = region_index(i_index);
        W = W + int_W(X(iElem), tri_area(iElem), paramsElem(iElem), x(triangles(iElem,:)), fun_W);
    end
    W = W*2*pi;
end
disp(['W = ' num2str(W)])

% R = 0.001;
% A_sour = R^2*pi;
% J = sRegions.getParam('source');
% I = A_sour*J;
% L = 2*W/(I^2);
% disp(['L = ' num2str(L)])

save(files.respth, 'W', '-append')


