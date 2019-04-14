// Gmsh project created on Sat Apr 13 21:25:15 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 0, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {0, 2, 0, 1.0};
//+
Point(5) = {1, 1, 0, 1.0};
//+
Point(6) = {1.1, 1, 0, 1.0};
//+
Point(7) = {0.9, 1, 0, 1.0};
//+
Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 1};
//+
Circle(5) = {7, 5, 6};
//+
Circle(6) = {6, 5, 7};
//+
Curve Loop(1) = {2, 3, 4, 1};
//+
Curve Loop(2) = {5, 6};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {5, 6};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {2, 1, 3, 4};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
