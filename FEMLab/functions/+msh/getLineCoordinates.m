function [x,y] = getLineCoordinates(pts, N)

x = zeros(N,1);
y = zeros(N,1);

nSegments = size(pts,1)-1;
segLen = round(N/nSegments);

for iSegment = 1:nSegments
    x(((iSegment-1)*segLen + 1):iSegment*segLen) = linspace(pts(iSegment,1), pts(iSegment+1,1), segLen);
    y(((iSegment-1)*segLen + 1):iSegment*segLen) = linspace(pts(iSegment,2), pts(iSegment+1,2), segLen);
end

