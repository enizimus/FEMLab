// Gmsh project created on Sat Mar 30 10:34:30 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {-5, -5, 0, 1.0};
//+
Point(2) = {5, -5, 0, 1.0};
//+
Point(3) = {5, 5, 0, 1.0};
//+
Point(4) = {-5, 5, 0, 1.0};
//+
Point(5) = {0, 0, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 4};
//+
Circle(5) = {0, 0, 0, 1, 0, 2*Pi};
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
Physical Curve("dirichlet") = {4, 1, 2, 3};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
