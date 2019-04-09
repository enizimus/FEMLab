// Gmsh project created on Sun Apr 07 23:51:14 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0.2, 0.2, 0, 1.0};
//+
Point(2) = {-0.2, 0.2, 0, 1.0};
//+
Point(3) = {-0.2, -0.2, 0, 1.0};
//+
Point(4) = {0.2, -0.2, 0, 1.0};
//+
Point(5) = {1, 1, 0, 1.0};
//+
Point(6) = {-1, 1, 0, 1.0};
//+
Point(7) = {-1, -1, 0, 1.0};
//+
Point(8) = {1, -1, 0, 1.0};
//+
Line(1) = {2, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Line(5) = {6, 5};
//+
Line(6) = {5, 8};
//+
Line(7) = {8, 7};
//+
Line(8) = {7, 6};
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
