function calcNeumannBoundary(lines, srcParams, nLines)
% neumannNodes = unique(lines(:));
% nNeuNodes = length(neumannNodes);
% connMat = false(nLines, nNeuNodes);
% 
% for iLine = 1:nLines
%     I = lines(iLine,:) == neumannNodes;
%     I = logical(sum(I,2));
%     
%     connMat(iLine,I) = true;
% end

neumannNodes = lines(:);
lineNums = repmat(1:nLines,1,2)';
lineMap = containers.Map(neumannNodes, lineNums);