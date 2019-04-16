// Gmsh project created on Mon Apr 15 05:59:07 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {-1, -1, 0, 1.0};
//+
Point(2) = {1, -1, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {-1, 1, 0, 1.0};
//+
Point(5) = {0, 0, 0, 1.0};
//+
Point(6) = {-0.2, 0, 0, 1.0};
//+
Point(7) = {0.2, 0, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 4};
//+
Circle(5) = {6, 5, 7};
//+
Circle(6) = {7, 5, 6};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {5, 6};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {5, 6};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {1, 2, 3, 4};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
