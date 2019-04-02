function [C,h]=contourx(varargin)
% 2-D contour plot with linear profiles separately shown at a
% user-defined position. 
%
% SYNTAX (similar to contourf)
% contourx(Z)
% contourx(Z,n)
% contourx(Z,v)
% contourx(X,Y,Z)
% contourx(X,Y,Z,n)
% contourx(X,Y,Z,v)
% contourx(...,LineSpec)
% contourx(axes_handle,...)
% contourx(axes_handle,...)
% [C,h] = contourx(...)
%
% DESCRIPTION
% This function obtains a contour plot of 2D (x,y) data and draws the x- 
% and y-profiles of the variable at a point specified by a moving cursor. 
% The coordinates of the chosen point are shown at the top of the contour.
%
% Zooming in and out of the contour plot is possible by the common tools in
% the toolbar. The axes of the two smaller line plots are automatically
% updated accordingly. 
% 
% LineSpec accepts string specifiers for line type and color. It ignores
% marker symbols. 
%
% Minimal Working Example (MWE): 
%       contourx(peaks(20));
% 
% Other example calls:
%       Z=peaks(20); contourx(Z);
%       [C,h]=contourx(x,y,V,30);
%   or  contourx(fig_handle,x,y,V,30,'r-.');
%
% ---
% Francesco Sciortino - August 8th, 2015
% +++
% Many thanks to Cyprian Lewandowski for his precious advice.
% +++
%
screen_size= get(0, 'ScreenSize');
fig_dims=[screen_size(3)/6,screen_size(4)/10,screen_size(3)*3/5,screen_size(3)*2/5];
if nargin==6, 
    h_fig=varargin{1}; xin=varargin{2}; yin=varargin{3};
    Vin=varargin{4}; n=varargin{5}; linespec=varargin{6};
end
if nargin==5, 
     h_fig=varargin{1}; 
     xin=varargin{2}; yin=varargin{3};
     Vin=varargin{4}; n=varargin{5};
end
if nargin==4, 
    if isvector(varargin{1}), 
        h_fig=figure('Position',fig_dims); 
        xin=varargin{1}; yin=varargin{2};
        Vin=varargin{3}; n=varargin{4}; 
    else
        h_fig=varargin{1}; 
        xin=varargin{2}; yin=varargin{3};
        Vin=varargin{4}; n=20;
    end
end
if nargin==3,
    h_fig=figure('Position',fig_dims); 
    xin=varargin{1}; yin=varargin{2};
    Vin=varargin{3}; n=20; 
end
if nargin==2, 
    disp('contourx takes the same arguments as contourf. \n');
    error('Please input the correct number of arguments.');
end
if nargin==1, 
    h_fig=figure('Position',fig_dims); 
    Vin=varargin{1}; n=20;
    xin=1:size(Vin,1); yin=1:size(Vin,2); 
end
set(gcf,'Toolbar','figure'); 
% Create main contour plot
hmain=subplot('Position', [0.35,0.35,0.55,0.55]);
if exist('linespec','var'), [C,h]=contourf(hmain,xin,yin,Vin,n,linespec);
else [C,h]=contourf(hmain,xin,yin,Vin,n);
end
colorbar; set(hmain,'visible','off')
set(findall(hmain,'type','text'),'visible','on')
% Draw default straight lines
hold on;
def_x=0; def_y=0.375;
plot(hmain,[def_x def_x],[min(yin) max(yin)],'r--','linewidth',2);
hold on;
plot(hmain,[min(xin) max(xin)],[def_y def_y],'r--','linewidth',2);
title(hmain,['[x,y] = ' num2str(def_x) ',' num2str(def_y)])
% Index of crosshair point
[~,idx]=min(abs(xin-def_x));
[~,idy]=min(abs(yin-def_y));
% Plot the linear profiles on the sides
sh1=subplot('Position',[0.1,0.35,0.2,0.55]);
plot(sh1,Vin(:,idx),yin,'r');
grid on; ylabel(sh1,'y');
ylim(sh1,[min(yin), max(yin)]);
sh2=subplot('Position',[0.35,0.1,0.47,0.2]);
plot(sh2,xin,Vin(idy,:),'b');
xlabel(sh2,'x'); grid on;
xlim(sh2,[min(xin), max(xin)])
% Set the moving cursor
set(gcf,'WindowButtonMotionFcn',{@mouseMove,hmain,sh1,sh2,xin,yin,Vin});
end
% Callback functions for the moving cursor
function mouseMove(object, eventdata, hmain,sh1, sh2, xin, yin, Vin)
CP=get(hmain,'CurrentPoint'); %Obtain current point of the cursor
hhh=findobj(hmain, 'type','line');
delete(hhh); %delete previous lines
% Plot new lines
title(hmain,['[x,y] = ' num2str(CP(1,1)) ',' num2str(CP(1,2))])
xlims=get(hmain,'Xlim'); ylims=get(hmain,'Ylim');
plot(hmain,[xlims(1), xlims(2)],[CP(1,2) CP(1,2)],'b--','linewidth',2);
hold on;
plot(hmain,[CP(1,1), CP(1,1)],[ylims(1) ylims(2)],'r--','linewidth',2);
% New data indices
[~,idx]=min(abs(xin-CP(1,1)));
[~,idy]=min(abs(yin-CP(1,2)));
 
%Update side plots if the cursor is currently within the contour plot
if xlims(1)<CP(1,1) && CP(1,1)<xlims(2) && ylims(1)<CP(1,2) && CP(1,2)<ylims(2), 
    hhh_sh1=findobj(sh1,'type','line');
    hhh_sh2=findobj(sh2,'type','line');
    delete(hhh_sh1); delete(hhh_sh2); 
    subplot(sh1);
    plot(sh1, Vin(:,idx),yin,'r');
    grid on; ylabel(sh1,'y [m]'); xlabel(sh1,'Vin');
    ylim(sh1,[min(ylims), max(ylims)]);
    subplot(sh2);
    plot(sh2,xin,Vin(idy,:),'b');
    grid on; xlabel(sh2,'x [m]'); ylabel(sh2,'Vin')
    xlim(sh2,[min(xlims), max(xlims)])
end
% Maintain position of contour plot
set(hmain,'xlim',xlims); set(hmain,'ylim',ylims);
end
