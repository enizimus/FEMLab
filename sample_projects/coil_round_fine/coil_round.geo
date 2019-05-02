// Gmsh project created on Wed Apr 03 21:17:37 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {-3, -3, 0, 1.0};
//+
Point(2) = {-3, 3, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {3, -3, 0, 1.0};
//+
Point(5) = {0, 0, 0, 1.0};
//+
Line(1) = {2, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 1};
//+
Line(4) = {1, 2};
//+
Circle(5) = {0, 0, 0, 0.2, 0, 2*Pi};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {5};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {5};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {1, 2, 3, 4};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
