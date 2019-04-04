// Gmsh project created on Wed Apr 03 20:44:38 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 4, 0, 1.0};
//+
Point(3) = {4, 4, 0, 1.0};
//+
Point(4) = {4, 0, 0, 1.0};
//+
Point(5) = {0.5, 1.7, 0, 1.0};
//+
Point(6) = {0.3, 1.7, 0, 1.0};
//+
Point(7) = {0.3, 2.3, 0, 1.0};
//+
Point(8) = {0.5, 2.3, 0, 1.0};
//+
Line(1) = {7, 7};
//+
Line(1) = {7, 8};
//+
Line(2) = {8, 5};
//+
Line(3) = {5, 6};
//+
Line(4) = {6, 7};
//+
Line(5) = {2, 3};
//+
Line(6) = {3, 4};
//+
Line(7) = {4, 1};
//+
Line(8) = {1, 2};
//+
Curve Loop(1) = {5, 6, 7, 8};
//+
Curve Loop(2) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {1, 2, 3, 4};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {8, 5, 6, 7};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
