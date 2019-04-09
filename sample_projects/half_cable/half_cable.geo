// Gmsh project created on Mon Apr 08 23:39:49 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 2, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {2, 0, 0, 1.0};
//+
Point(5) = {0, 1, 0, 1.0};
//+
Point(6) = {0, 1.2, 0, 1.0};
//+
Point(7) = {0, 0.8, 0, 1.0};
//+
Circle(1) = {6, 5, 7};
//+
Line(2) = {6, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Line(5) = {4, 1};
//+
Line(6) = {1, 7};
//+
Line(7) = {7, 6};
//+
Curve Loop(1) = {1, 7};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {3, 4, 5, 6, -1, 2};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirichlet") = {2, 7, 6};
//+
Physical Curve("dirichlet") += {3, 4, 5};
//+
Physical Surface("source") = {1};
//+
Physical Surface("air") = {2};
