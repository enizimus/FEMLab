function [regparams, regs] = read_settings()

settings = {'$RegionParams'};
file_name = 'settings.txt';
file_path = '..\settings\';
input_file = [file_path,file_name];
fid = fopen(input_file);

line = get_line(fid);
if(strcmp(line, settings{1}))
    n_regparams = str2double(get_line(fid));
    regparams = zeros(1,n_regparams);
    regs = cell(1, n_regparams);
    for i_reg=1:n_regparams
        line = get_line(fid);
        line_split = strsplit(line, ' ');
        regs(i_reg) = line_split(1);
        regparams(i_reg) = str2double(line_split{2});
    end
    line = get_line(fid);
end
fclose(fid);

