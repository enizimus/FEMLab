function saveFigures(figPath, format, resolution)

figHandles = findobj('Type', 'figure');

if isempty(figHandles)
    error('No figures open!');
elseif length(figHandles) == 1
    figHandles = [figHandles];
end

for iFig = 1:length(figHandles)
    fig = figHandles(iFig);
    print(fig, [figPath 'figure_' num2str(iFig)], ['-d' format], ['-r' num2str(resolution)])
end