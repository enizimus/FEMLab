// Gmsh project created on Thu Mar 28 18:15:11 2019
SetFactory("OpenCASCADE");
//+
Circle(1) = {0, 0, 0, 0.2, 0, 2*Pi};
//+
Circle(2) = {0, 0, 0, 0.5, 0, 2*Pi};
//+
Circle(3) = {0, 0, 0, 1, 0, 2*Pi};
//+
Curve Loop(1) = {1};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {2};
//+
Curve Loop(3) = {1};
//+
Plane Surface(2) = {2, 3};
//+
Curve Loop(4) = {3};
//+
Curve Loop(5) = {2};
//+
Plane Surface(3) = {4, 5};
//+
Physical Curve("dirichlet") = {3};
//+
Physical Surface("air") = {3};
//+
Physical Surface("source") = {1};
//+
Physical Surface("iron") = {2};
