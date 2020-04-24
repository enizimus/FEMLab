# FEMLab

## Current state :

### Solver : 

- Electrostatic planar and axissymmetric problems
- Stationary current planar and axissymmetric problems
- Magnetostatic planar and axissymmetric problems 
- 1D and 2D triangular Elements for all problem types
- Dirichlet and Neumann boundary conditions for all problem types and Elements

### Postprocessing : 

- Display of calculated values depending on selected problem 
  - Electrostatic : V, E, D
  - Stationary current : V, E, J
  - Magnetostatic : A, B, H 
  - For vector values : 
    - Abs, Abs mesh, Quiver, Slice, Field lines - plots
  - For scalar values : 
    - Abs, Abs mesh, Slice - plots
  - Additional options 
- Calculate field or potential along a curve defined by a list of points and the total number of points to interpolate
- Calculate field or potential for selected mesh (zoom in and out) 
- Calculate energy for selected region : 
  - Electrostatic 
  - Magnetostatic  
  
## Some examples : 

### Electrostatic planar (Cylindrical charge) :
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_cylinder/plots/figure_0.png" width="500" alt="mesh_estatic_planar">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_cylinder/plots/figure_1.png" width="500" alt="field_vector_estatic_planar">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_cylinder/plots/figure_4.png" width="500" alt="potential_estatic_planar">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_cylinder/plots/figure_5.png" width="500" alt="field_abs_estatic_planar">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_cylinder/plots/figure_7.png" width="500" alt="fcomp_estatic_planar">

### Electrostatic axissymmetric (Spherical charge) :
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_sphere/plots/figure_9.png" width="500" alt="fvector_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_sphere/plots/figure_3.png" width="500" alt="fieldabs_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_sphere/plots/figure_5.png" width="500" alt="potential_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/charged_sphere/plots/figure_0.png" width="500" alt="fcomp_estatic_axissym">

### Stationary current field (Metal plates) :
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/metal_plates/plots/figure_7.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/metal_plates/plots/figure_6.png" width="500" alt="sd_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/metal_plates/plots/figure_4.png" width="500" alt="fvector_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/metal_plates/plots/figure_3.png" width="500" alt="fvector_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/metal_plates/plots/figure_2.png" width="500" alt="fvector_estatic_axissym">

### Magnetostatic planar (Long wire in plane) :
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/wire_in_plane/plots/figure_1.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/wire_in_plane/plots/figure_4.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/wire_in_plane/plots/figure_6.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/wire_in_plane/plots/figure_0.png" width="500" alt="mesh_estatic_axissym">

### Magnetostatic axissymmetric (Solenoid) :
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/long_solenoid/plots/figure_1.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/long_solenoid/plots/figure_3.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/long_solenoid/plots/figure_5.png" width="500" alt="mesh_estatic_axissym">
<img src="https://github.com/enizimus/FEMLab/blob/master/sample_projects/long_solenoid/plots/figure_0.png" width="500" alt="mesh_estatic_axissym">
