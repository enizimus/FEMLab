function [xy, hh] = even_stream_texture(varargin)
% Compute and plot evenly-spaced streamlines for a vector field with a
% texturing effect to produce results similar to the line integral
% convolution (LIC) technique as in [1].
%
% even_stream_texture(xx, yy, uu, vv)
% even_stream_texture(xx, yy, uu, vv, min_density)
% even_stream_texture(xx, yy, uu, vv, min_density, max_density)
% even_stream_texture(xy)
% even_stream_texture(..., Name, Value)
% [xy, hh] = even_stream_texture(...)
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
%   hh = Graphics object for streamlines
%
% Parameters (Name, Value):
%   'LineWidth': line width as in plot(), default = 0.5
%   'Period': length of periodic pattern in arbitrary units, default
%       is 1, higher values will produce a longer repeat distance
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
%   xy = even_stream_texture(xx, yy, uu, vv, 20, 40, 'Period', 2);
%   subplot(1,2,2)
%   even_stream_texture(xy, 'Period', 0.5);
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
parser.addParameter('LineWidth', 0.5);
parser.addParameter('Period', 1);

parser.parse(varargin{:});
xx_or_xy = parser.Results.xx_or_xy;
yy = parser.Results.yy;
uu = parser.Results.uu;
vv = parser.Results.vv;
min_density = parser.Results.min_density;
max_density = parser.Results.max_density;
line_width = parser.Results.LineWidth;
period = parser.Results.Period;

validateattributes(period, {'numeric'}, {'scalar', 'positive'}, ...
    mfilename, 'period');

% get stream lines
optional = ~[isempty(yy), isempty(uu), isempty(vv), isempty(min_density), isempty(max_density)];
if all(optional)
    xx = xx_or_xy;
    xy = even_stream_data(xx, yy, uu, vv, min_density, max_density);
elseif ~any(optional)
    xy = xx_or_xy;
else
    error('Invalid input arguments, see help %s', mfilename)
end

% convert period to approximate number of points
mean_segment_length = nanmean(sqrt(sum(diff(xy).^2, 2)));
period = round(period*0.25*min(range(xy))/mean_segment_length);

% reformat streamlines as segments 
num_segments = size(xy, 1)-2*sum(isnan(xy(:,1)))-1;
x_segment = nan(num_segments, 2);
y_segment = nan(num_segments, 2);
current_segment = 0;
for ii = 1:size(xy,1)-1           
    % skip line endpoints, nothing to plot
    if any(isnan(xy(ii,1:2))) || any(isnan(xy(ii+1,1:2)))
        continue
    end
    current_segment = current_segment+1;
    x_segment(current_segment, :) = xy(ii:ii+1,1);
    y_segment(current_segment, :) = xy(ii:ii+1,2);
end

% get colormap
num_colors = 256;
colors = gray(num_colors);

% get colormap index for each segment
idx = (1:num_segments)';
color_coeff = 0.5*(1+sin(2*pi*idx/period)) + mod(idx, period)/(period-1);
color_coeff = (color_coeff-min(color_coeff))/range(color_coeff);
c_segment = min(num_colors, max(1, round(num_colors*color_coeff)));

% create plot: for efficieny, plot all segments with the same color at once
unique_colors = unique(c_segment);
num_unique_colors = length(unique_colors); 
hh = gobjects(num_unique_colors,1);
for ii = 1:num_unique_colors
    % get segments of this color
    cc = unique_colors(ii);
    is_cc = find(c_segment==cc);
    num_segment_cc = length(is_cc);
    x_segment_cc = nan(3*num_segment_cc, 1);
    x_segment_cc(1:3:end) = x_segment(is_cc, 1);
    x_segment_cc(2:3:end) = x_segment(is_cc, 2);    
    y_segment_cc = nan(3*num_segment_cc, 1);
    y_segment_cc(1:3:end) = y_segment(is_cc, 1);
    y_segment_cc(2:3:end) = y_segment(is_cc, 2);    
    % plot all segments at once
    hh(ii) = plot(x_segment_cc, y_segment_cc, ...
        'LineWidth', line_width, 'Color', colors(cc, :));
    hold on
end