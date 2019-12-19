function [xy, dist, hh] = even_stream_taper(varargin)
% Compute and plot evenly-spaced streamlines for a vector field with a
% taper effect as in [1].
%
% even_stream_taper(xx, yy, uu, vv)
% even_stream_taper(xx, yy, uu, vv, min_density)
% even_stream_taper(xx, yy, uu, vv, min_density, max_density)
% even_stream_taper(xy, dist)
% even_stream_taper(..., Name, Value)
% [xy, dist, hh] = even_stream_taper(...)
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
%   dist = Vector, containing distance to nearest neighboring streamline,
%       as produced by even_stream_data
%   hh = Graphics object for streamlines
%
% Parameters (Name, Value):
%   'LineWidthMin': minimum line width as in the built-in plot(), default = 0.5
%   'LineWidthMax': maximum line width as in the built-in plot(), default = 2
%   'Color': line color as in plot(), default = 'b'
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
%   [xy, dist] = even_stream_taper(xx, yy, uu, vv, 1, 4, ...
%       'LineWidthMin', 0.5, 'LineWidthMax', 3);
%   subplot(1,2,2)
%   even_stream_taper(xy, dist, ...
%       'LineWidthMin', 0.1, 'LineWidthMax', 5, 'Color', 'r');
% %

% handle inputs
parser = inputParser;
parser.CaseSensitive = false;
parser.PartialMatching = false;
parser.KeepUnmatched = false;

parser.addRequired('xx_or_xy');
parser.addOptional('yy_or_dist', []);
parser.addOptional('uu', []);
parser.addOptional('vv', []);
parser.addOptional('min_density', []);
parser.addOptional('max_density', []);
parser.addParameter('LineWidthMin', 0.5);
parser.addParameter('LineWidthMax', 2);
parser.addParameter('LineStyle', '-');
parser.addParameter('Color', 'b');

parser.parse(varargin{:});
xx_or_xy = parser.Results.xx_or_xy;
yy_or_dist = parser.Results.yy_or_dist;
uu = parser.Results.uu;
vv = parser.Results.vv;
min_density = parser.Results.min_density;
max_density = parser.Results.max_density;
line_width_min = parser.Results.LineWidthMin;
line_width_max = parser.Results.LineWidthMax;
line_color = parser.Results.Color;

% get stream lines
optional = ~[isempty(uu), isempty(vv), isempty(min_density), isempty(max_density)];
if all(optional)
    xx = xx_or_xy;
    yy = yy_or_dist;
    [xy, dist] = even_stream_data(xx, yy, uu, vv, min_density, max_density);
elseif ~any(optional)
    xy = xx_or_xy;
    dist = yy_or_dist;
else
    error('Invalid input arguments, see help %s', mfilename)
end

% reformat streamlines as segments 
num_segments = size(xy,1)-2*sum(isnan(xy(:,1)))-1;
x_segment = nan(num_segments, 2);
y_segment = nan(num_segments, 2);
d_segment = nan(num_segments, 1);
current_segment = 0;
for ii = 1:size(xy,1)-1           
    % skip line endpoints, nothing to plot
    if any(isnan(xy(ii,1:2))) || any(isnan(xy(ii+1,1:2)))
        continue
    end
    current_segment = current_segment+1;
    x_segment(current_segment, :) = xy(ii:ii+1,1);
    y_segment(current_segment, :) = xy(ii:ii+1,2);
    d_segment(current_segment) = mean(dist(ii:ii+1));
end

% get segment width rounded to 0.1 pt
dist_max = max(dist);
dist_min = min(dist);
w_coef = max(0.001, min(1, (d_segment-dist_min)/(dist_max-dist_min)));
w_segment = line_width_min+w_coef*(line_width_max-line_width_min);
w_segment = round(10*w_segment)/10;

% create plot: for efficieny, plot all segments with the same width at once
unique_widths = unique(w_segment);
num_unique_widths = length(unique_widths); 
hh = gobjects(num_unique_widths,1);
for ii = 1:num_unique_widths
    % get segments of this width
    ww = unique_widths(ii);
    is_ww = find(w_segment==ww);
    num_segment_ww = length(is_ww);
    x_segment_ww = nan(3*num_segment_ww, 1);
    x_segment_ww(1:3:end) = x_segment(is_ww, 1);
    x_segment_ww(2:3:end) = x_segment(is_ww, 2);    
    y_segment_ww = nan(3*num_segment_ww, 1);
    y_segment_ww(1:3:end) = y_segment(is_ww, 1);
    y_segment_ww(2:3:end) = y_segment(is_ww, 2);    
    % plot all segments at once
    hh(ii) = plot(x_segment_ww, y_segment_ww, ... 
        'LineWidth', ww, 'Color', line_color);   
    hold on
end