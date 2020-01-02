projPath = '/home/jpajser/Desktop/FEMDev/FEMLab/sample_projects/coil/';
projName = 'coil';

files = io.generateFiles(projPath, projName);

elemOrder = 2;
files = io.parseGmesh(files, elemOrder);
msh.regionsSetup(files)

