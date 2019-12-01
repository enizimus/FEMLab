clearvars
clc
close all

addpath('functions')

files = io.parseGmesh();

[optProb, mshType] = io.problemUI(files);

if(files.filesModified)
    
    msh.prepFieldData(files, mshType)
    slv.calcA(files, optProb)
    slv.evalA(files)                                    
    
    if(strcmp(optProb.problemClass, 'Mstatic'))
        slv.calcB(files, optProb)
    else
        slv.calcE(files, optProb)
    end
    
end

optProb.field = def.getField(optProb.problemClass);

slv.calcW(files, optProb, 1:4)

gfx.display(files, optProb, 'MSH', 'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'quiv',  'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'abstri', 'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'abs', 'saveplot', true)
gfx.display(files, optProb, 'A', 'type', 'abstri', 'saveplot', true)
gfx.display(files, optProb, 'A', 'type', 'abs', 'saveplot', true)
gfx.display(files, optProb, 'E', 'type', 'flines', 'nCont', 20)
gfx.display(files, optProb, 'E', 'type', 'slice')
