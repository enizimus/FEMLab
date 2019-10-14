clearvars
clc
close all

addpath('functions')

files = io.parseGmesh();

[optProb, mshType] = io.problemUI(files);

if(files.filesModified)
    
    msh.prep_field_data(files, mshType)
    slv.calc_A(files, optProb)
    slv.eval_A(files)
    
    if(strcmp(optProb.class, 'Mstatic'))
        slv.calc_B(files, optProb)
    else
        slv.calc_E(files, optProb)
    end
    
end

optProb.field = def.getField(optProb.class);

slv.calc_W(files, optProb, 1:4)

gfx.display(files, optProb, 'MSH', 'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'quiv',  'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'abstri', 'saveplot', true)
gfx.display(files, optProb, optProb.field, 'type', 'abs', 'saveplot', true)
gfx.display(files, optProb, 'A', 'type', 'abstri', 'saveplot', true)
gfx.display(files, optProb, 'A', 'type', 'abs', 'saveplot', true)
gfx.display(files, optProb, 'E', 'type', 'flines', 'nCont', 20)
gfx.display(files, optProb, 'E', 'type', 'slice')
