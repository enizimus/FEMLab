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
  
## Examples : 

### Electrostatic planar (Cylindrical charge) :
![Mesh](/docfigs/figs_cyl_charge/figure_0.png=200x200)
![Field Vector](/docfigs/figs_cyl_charge/figure_1.png=200x200)
![Potential](/docfigs/figs_cyl_charge/figure_4.png=200x200)
![Field abs](/docfigs/figs_cyl_charge/figure_5.png=200x200)
### Electrostatic axissymmetric (Spherical charge) :
![Field vector](/docfigs/figs_sphere_charge/figure_9.png=200x200)
![Field abs](/docfigs/figs_sphere_charge/figure_3.png=200x200)
![Potential](/docfigs/figs_sphere_charge/figure_5.png=200x200)
![Field comp](/docfigs/figs_sphere_charge/figure_0.png=200x200)
### Stationary current field (Metal plates) :
### Magnetostatic planar (Long wire in plane) :
### Magnetostatic axissymmetric (Solenoid) :

