function triNeumannLines = getTriNeumannLines(triangles, nTris, lines)

triNeumannLines = zeros(size(triangles));

for iTri = 1:nTris
    
   tri = triangles(iTri,:);
   
   line1 = tri([1,2]);
   line1T = fliplr(line1);
   line2 = tri([2,3]);
   line2T = fliplr(line2);
   line3 = tri([1,3]);
   line3T = fliplr(line3);
   
   triNeumannLines(iTri,1) = msh.getNeumannLines(line1, line1T, lines);
   triNeumannLines(iTri,2) = msh.getNeumannLines(line2, line2T, lines);
   triNeumannLines(iTri,3) = msh.getNeumannLines(line3, line3T, lines);
    
end