function [xy, hl, ha] = even_stream_arrow(varargin)
% Compute and plot evenly-spaced streamlines for a vector field with
% arrow glyphs to indicate the flow direction. Uses the 'arrow' package by
% Dr. Erik A. Johnson from the Mathworks File Exchange.
%
% even_stream_arrow(xx, yy, uu, vv)
% even_stream_arrow(xx, yy, uu, vv, min_density)
% even_stream_arrow(xx, yy, uu, vv, min_density, max_density)
% even_stream_arrow(xy)
% even_stream_arrow(..., Name, Value)
% [xy, hh] = even_stream_arrow(...)
%
% Arguments:
%   xx, yy: Matrices or vectors, x-coord and y-coord. If matrices, the
%       size must match uu and vv. If vectors, xx must match the number of
%       columns in uu and vv, and yy must match the number of rows.
%   uu, vv: Matrices, vector field x-component and y-component
%   min_density: Scalar, specifies the minimum density (spacing) of
%       streamlines. From the streamslice() documentation: "modifies the
%       automatic spacing of the streamlines. DENSITY must be greater than
%       0. The default value is 1; higher values will produce more
%       streamlines on each plane. For example, 2 will produce
%       approximately twice as many streamlines while 0.5 will produce
%       approximately half as many."
%   max_density: Scalar, " " maximum " ", default is 2
%   xy: Matrix, [x, y] coordinates for stream line points, each row is a
%       point, individual lines are separated by NaNs.
%   hl = Graphics object for streamlines
%   ha = Vector of graphics objects for arrows
%
% Parameters (Name, Value):
%   'LineStyle': line style as in plot(), default = '-'
%   'LineWidth': line width as in plot(), default = 0.5
%   'Color': line color as in plot(), default = 'b'
%   'ArrowLength': arrow head length in pixels, default = 20
%   'ArrowTipAngle': arrow head tip angle in degrees, default = 20
%   'ArrowBaseAngle': arrow head base angle in degrees, default = 10
%   'ArrowDensity': arrow head density in arbitrary units, default
%       is 1, higher values will produce more closey spaced arrows
%  
% References: 
% [1] Jobard, B., & Lefer, W. (1997). Creating Evenly-Spaced Streamlines of
%   Arbitrary Density. In W. Lefer & M. Grave (Eds.), Visualization in
%   Scientific Computing ?97: Proceedings of the Eurographics Workshop in
%   Boulogne-sur-Mer France, April 28--30, 1997 (pp. 43?55). inbook,
%   Vienna: Springer Vienna. http://doi.org/10.1007/978-3-7091-6876-9_5
%
% Example: Plot and replot streamlines
%   [xx, yy] = meshgrid(0:0.2:2, 0:0.2:2);
%   uu = cos(xx).*yy;
%   vv = sin(xx).*yy;
%   subplot(1,2,1)
%   xy = even_stream_arrow(xx, yy, uu, vv, 1, 2, 'Color', 'b');
%   subplot(1,2,2)
%   even_stream_arrow(xy, 'Color', 'r', 'ArrowDensity', 3);
% %

% handle inputs
parser = inputParser;
parser.CaseSensitive = false;
parser.PartialMatching = false;
parser.KeepUnmatched = false;

parser.addRequired('xx_or_xy');
parser.addOptional('yy', []);
parser.addOptional('uu', []);
parser.addOptional('vv', []);
parser.addOptional('min_density', []);
parser.addOptional('max_density', []);
parser.addParameter('LineStyle', '-');
parser.addParameter('LineWidth', 0.5);
parser.addParameter('Color', 'b');
parser.addParameter('ArrowLength', 7);
parser.addParameter('ArrowTipAngle', 20);
parser.addParameter('ArrowBaseAngle', 45);
parser.addParameter('ArrowDensity', 1);

parser.parse(varargin{:});
xx_or_xy = parser.Results.xx_or_xy;
yy = parser.Results.yy;
uu = parser.Results.uu;
vv = parser.Results.vv;
min_density = parser.Results.min_density;
max_density = parser.Results.max_density;
line_style = parser.Results.LineStyle;
line_width = parser.Results.LineWidth;
color = parser.Results.Color;
arrow_length = parser.Results.ArrowLength;
arrow_tip_angle = parser.Results.ArrowTipAngle;
arrow_base_angle = parser.Results.ArrowBaseAngle;
arrow_density = parser.Results.ArrowDensity;

% get stream lines
optional = ~[isempty(yy), isempty(uu), isempty(vv), isempty(min_density), isempty(max_density)];
if all(optional)
    xx = xx_or_xy;
    xy = gfx.ext.even_stream_data(xx, yy, uu, vv, min_density, max_density);
elseif ~any(optional)
    xy = xx_or_xy;
else
    error('Invalid input arguments, see help %s', mfilename)
end

% plot lines
hl = plot(xy(:,1), xy(:,2), ...
    'LineStyle', line_style, 'LineWidth', line_width, 'Color', color);

% get approximate arrow spacing in number of points
mean_segment_length = nanmean(sqrt(sum(diff(xy).^2, 2)));
arrow_space = min(range(xy))/10/arrow_density; 
spc = round(arrow_space/mean_segment_length);

% plot arrows
xy_from = xy(spc:spc:end, 1:2);
xy_to = xy(1+spc:spc:end, 1:2);
if size(xy_from,1) > size(xy_to,1) % bugfix: xy_to is shorter in rare cases
    xy_from(end,:) = []; 
end
xy_nan = any(isnan(xy_from), 2) | any(isnan(xy_to), 2);
xy_from = xy_from(~xy_nan, :);
xy_to = xy_to(~xy_nan, :);
axis(axis); % recommended in arrow() to fix axes limits 

ha = gfx.ext.arrow(xy_from, xy_to, ...
    'Length', arrow_length, ...
    'TipAngle', arrow_tip_angle, ...
    'BaseAngle', arrow_base_angle, ...
    'FaceColor', color, 'LineStyle', 'none');
