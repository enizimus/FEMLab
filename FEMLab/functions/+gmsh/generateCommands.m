function cmd = generateCommands(files, sys, elemOrder, sep)

cmd = struct();
Gmesh = ['.' sep 'gmesh' sep 'gmsh_', sys];

cmd.Gmesh = Gmesh;
cmd.editGeo = [Gmesh, ' ', files.geoFile];
cmd.meshAndSave = [Gmesh ' ' files.geoFile ' -2 -order ' num2str(elemOrder) ' -format msh22 -o ' files.mshFile];
cmd.refineMesh = [Gmesh ' ' files.mshFile ' -refine -format msh22'];
cmd.resetMesh = [Gmesh ' -1 -format msh22 -o ' files.mshFile];
%cmd.setMeshOrder = [Gmesh];