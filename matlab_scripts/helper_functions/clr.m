% CLR provides the color in RGB scale from a color list
% function [clr_rgb,clr_str,clr_id] = clr(in)
%
% INPUT:
%   in =                                                                                            
%       - no input (empty), e.g. clr()                                                              
%       - a string identifying the color name, e.g. clr('red_orange')                               
%       - an integer identifying the index for the color list, e.g. clr(28)                         
%       - two strings identifying the color type and the shade respectively, e.g. clr('red','orange')    
%       - the string "print_color_list' if you want to print the color list, e.g. clr('print_color_list');
%
% OUTPUT
%   clr_rgb = [R G B] is the code for the color in RGB scale                                        
%   clr_str = color name                                                                            
%   clr_id  = color number                                                                          
%
% EXAMPLES
%   the call clr_rgb = clr(1)
%       returns 
%   clr_rgb =  200   186   128
%
%   the call [clr_rgb,clr_str] = clr()
%       returns a random color, for instance
%   clr_rgb = 0    86   130
%   clr_str = capri_blue
%
%   the call [clr_rgb,clr_str,clr_id] = clr(10)
%       returns 
%   clr_rgb =  220   181    43
%   clr_str = lemon_yellow
%   clr_id  = 10
%
%   the call [clr_rgb,clr_str,clr_id] = clr('lemon_yellow')
%       returns
%   clr_rgb = 220   181    43
%   clr_str = lemon_yellow
%   clr_id  = 10
%
%   the call [clr_rgb,clr_str,clr_id] = clr('yellow','lemon')
%       returns
%   clr_rgb = 220   181    43
%   clr_str = lemon_yellow
%   clr_id  = 10
%
%   the call [clr_rgb,clr_str,clr_id] = clr('lemon','yellow')
%       returns
%   clr_rgb = 220   181    43
%   clr_str = lemon_yellow
%   clr_id  = 10
%
%   the call clr('print_color_list')
%       prints the color list on the command window
%
% NOTE
%   you can add other colors to the list. In that case, append the new color at the end of the list.
%
%   Ref. https://web.njit.edu/~kevin/rgb.txt.html
%   Ref. http://cloford.com/resources/colours/500col.htm
%   Ref. http://rgb.to/html-color-names/1
%
% ? Copyright Ennio Condoleo & Miriam Monteleone, Jun-21-2017
%
function [varargout] = clr(varargin)
   
% color list
color_list = {  ...  
166, 232, 250, 'bleu';
200, 186, 128, 'green_beige';
206, 177, 129, 'pale_beige';
210, 173, 107, 'sand_yellow';
246, 172, 000, 'signal_yellow';
228, 164, 000, 'golden_yellow';
197, 147, 000, 'honey_yellow';
228, 153, 000, 'maize_yellow';
230, 145, 000, 'chrome_yellow';
171, 127, 075, 'brown_beige';
220, 181, 043, 'lemon_yellow';
228, 219, 197, 'oyster_pearl_white';
220, 197, 149, 'ivory';
231, 214, 182, 'light_iv';
240, 232, 064, 'sulphur_yellow';
245, 172, 072, 'saffron_yellow';
250, 210, 051, 'zinc_yellow';
164, 144, 119, 'grey_beige';
160, 145, 098, 'olive_yellow';
190, 074, 034, 'red_orange';
194, 051, 028, 'vermillion';
247, 119, 038, 'pastel_orange';
236, 083, 000, 'pure_orange';
239, 107, 027, 'bright_red_orange';
225, 081, 005, 'traffic_orange';
209, 089, 026, 'signal_orange';
233, 114, 190, 'deep_orange';
217, 097, 072, 'salmon_orange';
169, 030, 031, 'flame_red';
158, 021, 025, 'signal_red';
159, 022, 028, 'carmine_red';
134, 002, 023, 'ruby_red';
204, 110, 115, 'antique_pink';
222, 154, 164, 'light_pink';
169, 054, 041, 'coral_red';
207, 077, 090, 'rose';
207, 056, 074, 'strawberry_red';
190, 017, 016, 'traffic_red';
210, 103, 082, 'salmon_red';
176, 019, 059, 'rasberry_red';
169, 045, 056, 'orient_red';
133, 093, 129, 'red_lilac';
146, 057, 074, 'red_violet';
204, 089, 142, 'heather_violet';
104, 022, 055, 'claret_violet';
124, 099, 153, 'blue_lilac';
148, 043, 111, 'traffic_purple';
071, 033, 057, 'purple_violet';
138, 066, 128, 'signal_violet';
156, 131, 143, 'pastel_violet';
192, 053, 115, 'magenta';
051, 115, 095, 'patina_green';
041, 105, 052, 'emerald_green';
042, 095, 043, 'leaf_green';
078, 083, 058, 'olive_green';
015, 067, 067, 'blue_green';
012, 064, 048, 'moss_green';
059, 059, 049, 'grey_olive';
046, 055, 037, 'bottle_green';
049, 047, 032, 'green';
139, 224, 166, 'best_green';
036, 052, 039, 'fir_green';
065, 110, 050, 'grass_green';
104, 127, 088, 'reseda_green';
044, 060, 055, 'black_green';
118, 117, 087, 'reed_green';
068, 064, 047, 'yellow_olive';
056, 059, 050, 'olive_dark';
000, 103, 077, 'turquoise_green';
078, 133, 065, 'may_green';
077, 156, 053, 'yellow_green';
175, 207, 170, 'pastel_green';
058, 071, 050, 'chrome_green';
130, 156, 120, 'pale_green'; 
057, 053, 038, 'brown_olive';
000, 129, 082, 'traffic_green';
088, 113, 059, 'fern_green';
000, 089, 076, 'opal_green';
116, 184, 181, 'turkish_green';
048, 084, 067, 'pine_green';
000, 011, 059, 'mint_green';
000, 255, 127, 'spring_green';
144, 238, 144, 'light_green';
152, 251, 152, 'pale_green';
000, 100, 000, 'dark_green';
173, 255, 047, 'green_yellow';
128, 128, 000, 'olive';
107, 142, 035, 'olive_drab';
000, 126, 078, 'signal_green';
062, 133, 125, 'mint_turquoise';
114, 170, 168, 'pastel_turquoise';
118, 132, 138, 'squirrel_grey';
141, 149, 155, 'silver_grey';
130, 123, 099, 'olive_grey';
118, 116, 101, 'moss_grey';
151, 151, 153, 'signal_grey';
107, 111, 108, 'mouse_grey';
117, 104, 090, 'beige_grey';
118, 098, 063, 'kaki_grey';
088, 092, 081, 'green_grey';
087, 090, 085, 'tarpaulin_grey';
081, 088, 091, 'iron_grey';
087, 093, 094, 'basalt_grey';
085, 080, 066, 'brown_grey';
078, 081, 087, 'slate_grey';
054, 061, 065, 'anthacrite_grey';
047, 051, 053, 'black_grey';
071, 069, 064, 'umber_grey';
124, 126, 115, 'concrete_grey';
068, 073, 079, 'graphite_grey';
052, 063, 065, 'granite_grey';
141, 138, 129, 'stone_grey';
090, 102, 107, 'blue_grey';
179, 175, 156, 'pebble_grey';
121, 127, 114, 'cement_grey';
144, 135, 109, 'yellow_grey'; 
193, 197, 192, 'light_grey';
146, 142, 140, 'platinum_grey';
122, 124, 122, 'dust_grey';
172, 174, 166, 'agate_grey';
108, 105, 097, 'quarz_grey';
150, 157, 161, 'window_grey';
141, 145, 145, 'traffic_grey_a';
077, 081, 080, 'traffic_grey_b';
182, 178, 166, 'silk_grey';
140, 145, 148, 'telegrey_1';
124, 131, 135, 'telegrey_2';
198, 198, 197, 'telegrey_4';
134, 105, 060, 'green_brown';
156, 100, 041, 'ocher_brown';
117, 072, 054, 'signal_brown';
126, 078, 040, 'clay_brown';
140, 072, 050, 'copper_brown';
104, 065, 037, 'fawn_brown';
115, 078, 041, 'olive_brown';
089, 056, 039, 'nut_brown';
099, 051, 045, 'red_brown';
072, 054, 038, 'sepia_brown';
091, 048, 043, 'chestnut_brown';
077, 048, 038, 'mahogany_brown';
064, 043, 037, 'chocolate_brown';
059, 051, 050, 'grey_brown';
032, 026, 024, 'dark_brown';
164, 089, 045, 'orange_brown';
122, 084, 059, 'beige_brown';
115, 086, 068, 'pale_brown';
079, 059, 045, 'earth_brown';
237, 227, 211, 'cream';
215, 214, 202, 'grey_white';
237, 237, 231, 'signal_white';
038, 038, 039, 'signal_black';
018, 019, 020, 'jet_black';
166, 171, 181, 'white_aluminium';
125, 122, 120, 'grey_aluminium';
241, 238, 226, 'pure_white';
033, 035, 038, 'graphite_black';
237, 238, 232, 'traffic_white';
029, 028, 029, 'traffic_black';
198, 204, 196, 'papyrus_white';
000, 000, 000, 'black';
255, 000, 000, 'red';
000, 255, 000, 'lime_green';
000, 000, 255, 'blue';
250, 128, 114, 'salmon';
205, 112, 084, 'dark_salmon';
160, 082, 045, 'dark_sienna';
238, 121, 066, 'sienna';
255, 127, 000, 'orange';
240, 255, 240, 'honeydew';
193, 205, 193, 'dark_honeydew';
255, 114, 086, 'coral';
205, 091, 069, 'dark_coral';
255, 228, 196, 'bisque';
205, 183, 158, 'dark_bisque';
255, 218, 185, 'peach_puff';
240, 160, 122, 'light_coral';
205, 102, 000, 'dark_orange';
255, 020, 147, 'deep_pink';
255, 105, 180, 'hot_pink';
205, 092, 092, 'indian_red';
255, 182, 193, 'light_pink';
255, 228, 225, 'misty_rose';
208, 032, 144, 'violet_red';
139, 026, 026, 'fire_brick';
209, 146, 117, 'feldspar';
205, 000, 000, 'dark_red';
139, 000, 000, 'deep_red';
238, 092, 066, 'tomato';
255, 028, 174, 'spicy_pink';
255, 000, 255, 'magenta';
139, 000, 139, 'dark_magenta';
085, 026, 139, 'dark_purple';
173, 234, 234, 'turquoise';
250, 235, 215, 'antique_white';
248, 248, 255, 'ghost_white';
255, 222, 173, 'navajo_white';
245, 245, 245, 'white_smoke';
255, 255, 240, 'ivory';
255, 245, 238, 'seashell';
255, 250, 250, 'snow';
255, 255, 255, 'white';
217, 217, 243, 'quartz';
184, 134, 011, 'dark_goldenrod';
238, 221, 130, 'light_goldenrod';
255, 239, 213, 'papaya_whip';
238, 180, 034, 'goldenrod';
255, 255, 000, 'yellow';
255, 215, 000, 'gold';
133, 099, 099, 'green_copper';
230, 232, 250, 'silver';
139, 069, 019, 'chocolate';
139, 090, 043, 'tan';
133, 094, 066, 'dark_wood';
056, 176, 222, 'summer_sky';
077, 077, 255, 'navy_blue';
064, 224, 208, 'green_turquoise';
127, 255, 212, 'aquamarine';
064, 064, 064, 'deep_gray';
084, 084, 084, 'grey';
105, 105, 105, 'dark_grey';
161, 161, 161, 'light_grey';
201, 201, 201, 'soft_grey';
235, 235, 235, 'white_grey';   
% ... you can add other colors here
};
% input check
n = size(color_list,1);
if nargin==0
    id_clr    = rem(ceil(abs(rand(1))*n^2),n);
    clr_shade = [];
    CLR       = [color_list{id_clr,1},color_list{id_clr,2},color_list{id_clr,3}];
elseif nargin==1
    id_clr    = varargin{1};
    clr_shade = [];
    CLR       = [];
elseif nargin==2
    id_clr    = varargin{1};
    clr_shade = varargin{2};
    CLR       = [];
else
    error('clr:input','Too many inputs.');
end
% find color
if isempty(CLR)
    if ischar(id_clr)
        id_clr = lower(id_clr);
        if strcmp(id_clr,'print_color_list')
            fprintf('\n  R   G   B   name \n ---------------------------- \n');
            for j = 1:n
                fprintf(' %03d %03d %03d %s\n',color_list{j,1},color_list{j,2},color_list{j,3},color_list{j,4});
            end
            fprintf(' ---------------------------- \n\n');
            return;
        end
        find_clr = false(n,1);
        for j = 1:n
            find_clr(j) = ~isempty(strfind(color_list{j,4},id_clr)); 
        end
        find_clr = find(find_clr)';
        if length(find_clr)>1
            aux = true;
            for j = find_clr
                if strfind(color_list{j,4},clr_shade)
                    id_clr = j;
                    aux    = false;
                    break;
                elseif strcmp(color_list{j,4},id_clr)
                    id_clr = j;
                    aux    = false;
                    break;
                end
            end
            if aux
               id_clr = randsample(find_clr,1); 
               warning('clr:input','No match for color type: a random type is selected for the color desired!');
            end
        elseif length(find_clr)==1
            id_clr = find_clr;
        else
            warning('clr:input','No color found! A random color is provided!');
            id_clr = rem(ceil(abs(rand(1))*n^2),n);
        end
    else
        if id_clr>n
            warning('clr:input','The index is greater than the number of available colors. A random color is provided!');
        end
        id_clr = rem(abs(id_clr),n);
    end
    CLR = [color_list{id_clr,1},color_list{id_clr,2},color_list{id_clr,3}];
end
% output
if nargout<2
    varargout{1} = CLR;
elseif nargout==2
    varargout{1} = CLR;
    varargout{2} = color_list{id_clr,4};
elseif nargout==3
    varargout{1} = CLR;
    varargout{2} = color_list{id_clr,4};
    varargout{3} = id_clr;
else
    error('clr:output','Too many outputs.');
end