function display(files, prob_opt, plots, varargin)

% ----- Input parser settings ----------
validPlots = {'B', 'A', 'MSH'};
validTypes = {'abs', 'quiv', 'cont', 'slice'};
validFormats = {'-dpng' '-depsc'};

defType = 'abs';
defAxesOn = true;
defPrint = false;
defFormat = '-dpng';
defFlineson = true;
defNCont = 15;

checkPlots = @(x) any(validatestring(x, validPlots));
checkTypes = @(x) any(validatestring(x, validTypes));
checkFormat = @(x) any(validatestring(x, validFormats));

p = inputParser;
addRequired(p, 'files', @isstruct)
addRequired(p, 'prob_opt', @isstruct)
addRequired(p, 'plots', checkPlots)
addOptional(p, 'type', defType, checkTypes)
addOptional(p, 'axesOn', defAxesOn, @islogical)
addOptional(p, 'doPrint', defPrint, @islogical)
addOptional(p, 'printFormat', defFormat, checkFormat)
addOptional(p, 'fieldLinesOn', defFlineson, @islogical)
addOptional(p, 'nCont', defNCont, @isnumeric)

parse(p, files, prob_opt, plots, varargin{:});
% ----- End ---------------------------

if(~iscell(p.Results.type))
    prob_opt.fieldplt = {p.Results.type};
else
    prob_opt.fieldplt = p.Results.type;
end

prob_opt.ncont = p.Results.nCont;
prob_opt.plots = plots;
prob_opt.do_print = p.Results.doPrint;
prob_opt.print_format = p.Results.printFormat;
prob_opt.axes_on = p.Results.axesOn;
prob_opt.flines_on = p.Results.fieldLinesOn;

if(strcmp(plots, 'MSH'))
    gfx.display_mesh(files, prob_opt)
else
    gfx.display_wrapper(files, prob_opt)
end



