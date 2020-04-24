function W = calcW(files, settings, regions)

strField = [def.getFieldLetter(settings.problemClass), 'c'];

load(files.respth, strField, 'elements', 'nLines', 'regSet', ...
    'elemsRegion', 'areaTri', 'triangles', 'const')

if(isempty(regions))
    regions = [1:length(regSet)];
end

X = eval(strField);
[paramsElem, ~] = msh.getElemParams(settings, elemsRegion, regSet, const);

regionIndex = false(size(elemsRegion));
for iReg = 1:length(regions)
    tempIndex = elemsRegion == regions(iReg);
    regionIndex = regionIndex | tempIndex;
end

regionIndex = regionIndex(nLines+1:end);
paramsElem = paramsElem(nLines+1:end);
nElems = length(regionIndex);

if(def.isPlanar(settings.symmetry))
    W = 0.5*paramsElem(regionIndex)'.*X(regionIndex).^2*areaTri(regionIndex);
else
    regionIndex = find(regionIndex);
    load(files.respth, 'x', 'y')
    int_W = slv.getFuns('Wint');
    fun_W = slv.getFuns('W');
    W = 0;
    for i_index = 1:length(regionIndex)
        iElem = regionIndex(i_index);
        W = W + int_W(X(iElem), areaTri(iElem), paramsElem(iElem), x(triangles(iElem,:)), fun_W);
    end
    W = W*pi*2;
end