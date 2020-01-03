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


---
# msh format : 
- Element types : 
    - (1) 2-node line. **(1st order meshing uses this one)**
    - (2) 3-node triangle. **(1st order meshing uses this one)**
    - (8) 3-node second order line (2 nodes associated with the vertices and 1 with theedge). **(2nd order meshing uses this one)**
    - (9) 6-node second order triangle (3 nodes associated with the vertices and 3 withthe edges). **(2nd order meshing uses this one)**
    - (15) 1-node point.
    - (20) 9-node third order incomplete triangle (3 nodes associated with the vertices, 6with the edges)
    - (21) 10-node third order triangle (3 nodes associated with the vertices, 6 with theedges, 1 with the face) **(3rd order meshing uses this one)**
    - (26) 4-node third order edge (2 nodes associated with the vertices, 2 internal to theedge) **(3rd order meshing uses this one)**

![Element types](element_types.png)
