function generateCommands(files)

cmd = struct();
Gmesh = '.\gmesh\gmsh';

cmd.Gmesh = Gmesh;
cmd.openGeo = [Gmesh, ' ', files.geoFile];
cmd.meshAndSave = [Gmesh, ' -2 -format msh22 -o ', files.mshFile];

save(files.respth, 'cmd', '-append')
