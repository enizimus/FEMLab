function display(files, optProb, plots, varargin)

% ----- Input parser settings ----------
validPlots = {'B', 'H', 'A', 'E', 'D', 'J', 'V', 'MSH' 'POT'};
validTypes = {'abs', 'abstri', 'quiv', ...
              'cont', 'slice', 'flines'};
validFormats = {'-dpng' '-depsc'};

defType = 'abs';
defAxesOn = true;
defPrint = false;
defFormat = '-dpng';
defFlineson = true;
defNCont = 24;
defRes = 200;
defHide = false;

checkPlots = @(x) any(validatestring(x, validPlots));
checkTypes = @(x) any(validatestring(x, validTypes));
checkFormat = @(x) any(validatestring(x, validFormats));

p = inputParser;
addRequired(p, 'files', @isstruct)
addRequired(p, 'optProb', @isstruct)
addRequired(p, 'plots', checkPlots)
addParameter(p, 'type', defType, checkTypes)
addParameter(p, 'axesOn', defAxesOn, @islogical)
addParameter(p, 'saveplot', defPrint, @islogical)
addParameter(p, 'format', defFormat, checkFormat)
addParameter(p, 'fieldLinesOn', defFlineson, @islogical)
addParameter(p, 'nCont', defNCont, @isnumeric)
addParameter(p, 'res', defRes, @isnumeric)
addParameter(p, 'hideFig', defHide, @islogical)

parse(p, files, optProb, plots, varargin{:});
% ----- End ---------------------------

if(~iscell(p.Results.type))
    optProb.fieldplt = {p.Results.type};
else
    optProb.fieldplt = p.Results.type;
end

optProb.nCont = p.Results.nCont;
optProb.plots = plots;
optProb.doPrint = p.Results.saveplot;
optProb.printFormat = p.Results.format;
optProb.axesOn = p.Results.axesOn;
optProb.flinesOn = p.Results.fieldLinesOn;
optProb.res = p.Results.res;
optProb.hideFig = p.Results.hideFig;

if(strcmp(plots, 'MSH'))
    gfx.dispMesh(files, optProb)
else
    gfx.wrappDisp(files, optProb)
end



