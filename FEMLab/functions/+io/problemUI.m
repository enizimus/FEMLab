function [optProb, mshType] = problemUI(files)

varList = {'optProb', 'mshType'};
if(files.filesModified | ~io.isSaved(files, varList))
    prompt = {'Problem class', 'Problem type : ','Calculation type : ', 'Validation problem : ', 'Mesh boundary : ', 'Source type : '};
    dlgtitle = 'coil.msh options';
    dims = [1 35];
    definput = {'Estatic', 'axssym', 'int', 'dsad', 'rect', 'rect'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    optProb.class = answer{1};
    optProb.type = answer{2};
    optProb.int = strcmp(answer{3}, 'int');
    optProb.valid = answer{4};
    mshType.edge = answer{5};
    mshType.src =  answer{6};
    
    save(files.respth, 'optProb', 'mshType', '-append')
else
    load(files.respth, 'optProb', 'mshType')
end
