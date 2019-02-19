function [regparams, regs] = read_settings(file_name)

settings = {'$Parameters'};
file_name = strrep(file_name, '.msh', '_settings.txt');
file_path = '..\settings\';
input_file = [file_path,file_name];
if(exist(input_file, 'file')==2)
    fid = fopen(input_file);
else
    disp({'Setting file not found at : ', input_file})
end

line = get_line(fid);
if(strcmp(line, settings{1}))
    n_regparams = str2double(get_line(fid));
    regparams = zeros(1,n_regparams);
    %params_tag = zeros(1,n_regparams);
    regs = cell(1, n_regparams);
    for i_reg=1:n_regparams
        line = get_line(fid);
        line_split = strsplit(line, ' ');
        regs(i_reg) = line_split(1);
        %params_tag(i_reg) = str2double(line_split{2});
        regparams(i_reg) = str2double(line_split{2});
    end
    line = get_line(fid);
end
fclose(fid);
% choosing a region parameter using the region tag atribute, so that when
% using the array regparams we access the according parameter through the
% tag of the region in question regparams(2) would return the region
% parameter of the region with tag = 2 (third row in mesh file)
%parameters = zeros(1, max(params_tag));
%parameters(params_tag) = regparams;



