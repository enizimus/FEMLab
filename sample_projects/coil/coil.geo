// Gmsh project created on Wed Jan  1 23:10:26 2020
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 1, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {1, 0, 0, 1.0};
//+
Line(1) = {2, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.55, 0.5, 0, 1.0};
//+
Point(7) = {0.45, 0.5, 0, 1.0};
//+
Circle(5) = {7, 5, 6};
//+
Circle(6) = {6, 5, 7};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Curve Loop(2) = {5, 6};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {5, 6};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {4, 3, 2, 1};
//+
Physical Surface("source") = {1};
//+
Physical Surface("air") = {2};
