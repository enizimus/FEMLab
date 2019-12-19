function [xy, dist] = even_stream_data(xx, yy, uu, vv, min_density, max_density)
% [xy, dist] = even_stream_data(xx, yy, uu, vv, min_density, max_density)
%
% Return evenly-spaced streamlines, and optionally minimum distance to
% neighboring lines.
%
% Required Arguments:
%   xx, yy: Matrices or vectors, x-coord and y-coord. If matrices, the
%       size must match uu and vv. If vectors, xx must match the number of
%       columns in uu and vv, and yy must match the number of rows.
%   uu, vv: Matrices, vector field x-component and y-component
%
% Optional Arguments:
%   min_density: 
%
%   max_density:
%
% Return:
%   xy: Matrix, [x, y] coordinates for stream line points, each row is a
%       point, individual lines are separated by NaNs.
%   dist: Vector, minimum distance to neighboring stream lines, only
%       computed only if nargout == 2.
%
% The core of this function is a modified version of the Mathworks
% nicestream() function, which is part of streamslice.m. Modifications
% include explicit control over line spacing, and a more sensible setting
% for stepsize (see streamline()) that avoids line crossing at high
% streamline density. The nicestreams() algorithm is a variant of that
% described in [1].
%
% References:
% [1] Jobard, B., & Lefer, W. (1997). Creating Evenly-Spaced Streamlines of
%   Arbitrary Density. In W. Lefer & M. Grave (Eds.), Visualization in
%   Scientific Computing ?97: Proceedings of the Eurographics Workshop in
%   Boulogne-sur-Mer France, April 28--30, 1997 (pp. 43?55). inbook,
%   Vienna: Springer Vienna. http://doi.org/10.1007/978-3-7091-6876-9_5
% %

%% parse and check inputs

% handle optional arguments
if isempty(min_density); min_density = 1.0; end
if isempty(max_density); max_density = 0.5; end

% convert coordinate vectors to grids, if indicated
if isvector(xx) && isvector(yy)
    [xx, yy] = meshgrid(xx, yy);
end

% check for sane values
validateattributes(xx, {'numeric'}, {'nonempty'}, mfilename, 'xx');
validateattributes(yy, {'numeric'}, {'size', size(xx)}, mfilename, 'yy');
validateattributes(uu, {'numeric'}, {'size', size(xx)}, mfilename, 'uu');
validateattributes(vv, {'numeric'}, {'size', size(xx)}, mfilename, 'vv');
validateattributes(min_density, {'numeric'}, {'scalar', '>' 0}, ...
    mfilename, 'min_density');
validateattributes(max_density, {'numeric'}, {'scalar', '>' 0}, ...
    mfilename, 'max_density');

% compute results
[xy, len] = get_stream_xy(xx, yy, uu, vv, min_density, max_density);
if nargout == 2
    dist = get_stream_dist(xy, len);
end

function [xy, len] = get_stream_xy(x, y, u, v, min_density, max_density)
% Return streamline vertices
% 
% Modified from Mathworks nicestreams() in streamlines.m
% %
    
num = 20;
nrstart = ceil(num*min_density);
ncstart = ceil(num*min_density);
nrend   = ceil(num*max_density);
ncend   = ceil(num*max_density);

xmin = min(x(:));
xmax = max(x(:));
ymin = min(y(:));
ymax = max(y(:));
xrange = xmax-xmin;
yrange = ymax-ymin;

incstartx = xrange/ncstart;
inrstarty = yrange/nrstart;
ixrangecs = ncstart/xrange*(1-eps);
iyrangers = nrstart/yrange*(1-eps);
ixrangece = ncend/xrange*(1-eps);
iyrangere = nrend/yrange*(1-eps);

stepsize = min( [0.1, (size(v)-1)./([nrend,ncend]-1)] );
streamoptions = [stepsize min(10000,sum(size(v))*2/stepsize)];

% startgrid and endgrid are used to keep track of the location/density
% of streamlines. As new streamlines are created, the values in these
% matrices will indicate whether a streamline has passed through each
% quadrant of the data space. startgrid is coarser grid, while endgrid
% is a finer grid. startgrid is used to decide whether to start a new
% streamline. If an existing streamline has already passed through a
% quadrant, we won't start a new streamline. endgrid is used to limit
% the density of the final streamlines. New streamlines will stop when
% the reach a quandrant that is already occupied by an existing
% streamline.
startgrid = zeros(nrstart,ncstart);
endgrid = zeros(nrend,ncend);

[r, c] = meshgrid(1:nrstart, 1:ncstart);
rc = [r(:) c(:)];
rc = rc(randperm(size(rc,1)),:); % randomize seed points

vertsout = {};
len = [];
for k = 1:size(rc,1)
    %if mod(k,100)==0, disp([num2str(k) '/' num2str(size(rc,1))]), end
    r = rc(k,1);
    c = rc(k,2);
    if startgrid(r,c)==0
        
        startgrid(r,c)=1;
        
        xstart = xmin+(c-.5)*incstartx;
        ystart = ymin+(r-.5)*inrstarty;
        vertsf = stream2(x,y, u, v,xstart,ystart,streamoptions);
        vertsb = stream2(x,y,-u,-v,xstart,ystart,streamoptions);
        verts = [vertsf vertsb];
        vo = cell(1,2);
        for q = 1:2
            vv = verts{q};
            
            nanpos = find(isnan(vv));
            if ~isempty(nanpos)
                if nanpos(1)==1
                    vv = [];
                else
                    vv = vv(1:nanpos(1)-1,:);
                end
            end
            
            if ~isempty(vv)
                tcc = floor( (vv(1,1)-xmin)*ixrangece )+1;
                trr = floor( (vv(1,2)-ymin)*iyrangere )+1;
            end
            
            for j=1:size(vv,1)
                xc = vv(j,1);
                yc = vv(j,2);
                
                % Calculate indices into startgrid (rr,cc), based on
                % the coordinates of this particular data point on this
                % streamline. As a streamline passes through
                % coordinates, mark them off so that we do not start
                % new streamlines in those coordinates.
                cc = floor( (xc-xmin)*ixrangecs )+1;
                rr = floor( (yc-ymin)*iyrangers )+1;
                if cc > 0 && cc <= ncstart && rr > 0 && rr <= nrstart
                    startgrid(rr,cc)=1;
                end
                
                % Now calculate rr and cc using a finer mesh so that
                % they are indices into endgrid. As a streamline passes
                % through coordinates, mark them off so that we do not
                % start new streamlines in those coordinates. If a new
                % streamline hits an existing streamline, then the new
                % streamline will be truncated.
                cc = floor( (xc-xmin)*ixrangece )+1;
                rr = floor( (yc-ymin)*iyrangere )+1;
                if cc <= 0 || cc > ncend || rr <= 0 || rr > nrend
                    break;
                elseif endgrid(rr,cc)==1
                    if ~(any(cc==tcc) && any(rr==trr))
                        break;
                    end
                else
                    tcc=cc; trr=rr;
                    endgrid(rr,cc)=1;
                end
            end
            vo{q} = vv(1:j-1,:);
            
        end
        vertsout{end+1} = [flipud(vo{2}); vo{1}(2:end,:)]; %#ok!        
        len(end+1) = size(vertsout{end}, 1); %#ok! store line length in pts
        vertsout{end+1} = [NaN, NaN]; %#ok! add NaNs to separate lines
    end    
end

% reformat cell array as single matrix with NaNs separating lines
xy = cell2mat(vertsout');

function dist = get_stream_dist(xy, len)
% Return distance to nearest vertex in neighboring streamline for all
% vertices in xy.
% %

num_lines = length(len);
stream_tri = delaunayTriangulation(xy(~isnan(xy(:,1)), :));
dist = nan(size(xy, 1), 1);
kk = 1;
for ii = 1:num_lines
    stream_xy = stream_tri.Points(1:len(ii), :);
    stream_tri.Points(1:len(ii), :) = [];
    [~, stream_dist] = nearestNeighbor(stream_tri, stream_xy);
    dist(kk:kk+len(ii)-1) = stream_dist;
    kk = kk+len(ii)+1;
    stream_tri.Points = [stream_tri.Points; stream_xy];
end
