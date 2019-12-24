# Gmesh scripting : 
---
- Starting gmesh application : 
    - *$ gmsh*
- Start gmesh and open a file : 
    - *$ gmsh [PATH]*
- Save Mesh with format '2.2.0.8' : 
    - *$ gmsh [PATH] -o [MESH_NAME] -format msh22 -save*
- Mesh [PATH] and save to [MESH_PATH] with format '2.2.0.8':
    - *$ gmsh [PATH] -2 -format msh22 -o [MESH_PATH]*

- **Mesh** and **Remesh** geo file (Mesh reset can be performed by meshing it with -1 (1D meshing)): 
    - *$ gmsh [GEO_PATH] -2 -format msh22 -o [MESH_PATH]*
- **Refine** previously generated mesh file : 
    - *$ gmsh [MESH_PATH] -refine -format msh22*