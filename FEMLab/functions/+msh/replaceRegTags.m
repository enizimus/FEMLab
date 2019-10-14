function element_regions = replaceRegTags(elements, nElems, subsTags)

dimDirichlet = 1;
dimNeumann = 2;
dimSource = 3;
dimOthers = 4;

element_regions = zeros(1, nElems);
iElem = 1;
while(iElem <= nElems)
    if(any(elements(iElem).tags(1) == subsTags(1,:)))
        element_regions(iElem) = dimDirichlet;
    elseif(any(elements(iElem).tags(1) == subsTags(2,:)))
        element_regions(iElem) = dimNeumann;
    elseif(any(elements(iElem).tags(1) == subsTags(3,:)))
        element_regions(iElem) = dimSource;
    elseif(any(elements(iElem).tags(1) == subsTags(4,:)))
        element_regions(iElem) = dimOthers;
    end
    iElem = iElem + 1;
end
