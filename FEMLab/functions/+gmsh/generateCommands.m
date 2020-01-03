function cmd = generateCommands(files, sys)

cmd = struct();
Gmesh = ['./gmesh/gmsh_', sys];

cmd.Gmesh = Gmesh;
cmd.editGeo = [Gmesh, ' ', files.geoFile];
cmd.meshAndSave = [Gmesh ' ' files.geoFile ' -2 -format msh22 -o ' files.mshFile];
cmd.refineMesh = [Gmesh ' ' files.mshFile ' -refine -format msh22'];
cmd.resetMesh = [Gmesh ' -1 -format msh22 -o ' files.mshFile];
%cmd.setMeshOrder = [Gmesh];