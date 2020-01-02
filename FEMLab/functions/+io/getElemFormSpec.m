function form = getElemFormSpec(elemOrder)

form = struct();

switch elemOrder 
    case 1
        form.nLineNodes = 2; % num_of_line_nodes
        form.nTriNodes = 3;  % num_of_tri_nodes
        form.specLen = 8;    % form_spec_length
        form.lineCode = 1;   % line code in mesh file
        form.triCode = 2;    % tri code in mesh file
    case 2
        form.nLineNodes = 3;
        form.nTriNodes = 6;
        form.specLen = 11;
        form.lineCode = 8;
        form.triCode = 9;
    case 3
        form.nLineNodes = 4;
        form.nTriNodes = 10;
        form.specLen = 15;
        form.lineCode = 26;
        form.triCode = 21;
        
end
        
form.spec = repmat(' %f', 1, form.specLen);
form.spec(1) = '';