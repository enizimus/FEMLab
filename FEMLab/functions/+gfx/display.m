function display(files, prob_opt, plots, varargin)

% ----- Input parser settings ----------
validPlots = {'B', 'A', 'E', 'MSH' 'POT'};
validTypes = {'abs', 'quiv', 'cont', 'slice'};
validFormats = {'-dpng' '-depsc'};

defType = 'abs';
defAxesOn = true;
defPrint = false;
defFormat = '-dpng';
defFlineson = true;
defNCont = 24;
defRes = 200;

checkPlots = @(x) any(validatestring(x, validPlots));
checkTypes = @(x) any(validatestring(x, validTypes));
checkFormat = @(x) any(validatestring(x, validFormats));

p = inputParser;
addRequired(p, 'files', @isstruct)
addRequired(p, 'prob_opt', @isstruct)
addRequired(p, 'plots', checkPlots)
addParameter(p, 'type', defType, checkTypes)
addParameter(p, 'axesOn', defAxesOn, @islogical)
addParameter(p, 'saveplot', defPrint, @islogical)
addParameter(p, 'format', defFormat, checkFormat)
addParameter(p, 'fieldLinesOn', defFlineson, @islogical)
addParameter(p, 'nCont', defNCont, @isnumeric)
addParameter(p, 'res', defRes, @isnumeric)

parse(p, files, prob_opt, plots, varargin{:});
% ----- End ---------------------------

if(~iscell(p.Results.type))
    prob_opt.fieldplt = {p.Results.type};
else
    prob_opt.fieldplt = p.Results.type;
end

prob_opt.ncont = p.Results.nCont;
prob_opt.plots = plots;
prob_opt.do_print = p.Results.saveplot;
prob_opt.print_format = p.Results.format;
prob_opt.axes_on = p.Results.axesOn;
prob_opt.flines_on = p.Results.fieldLinesOn;
prob_opt.res = p.Results.res;

if(strcmp(plots, 'MSH'))
    gfx.display_mesh(files, prob_opt)
elseif(strcmp(plots, 'POT'))
    gfx.display_potentials(files)
else
    gfx.display_wrapper(files, prob_opt)
end



