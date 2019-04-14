// Gmsh project created on Fri Apr 12 22:49:29 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {-0.3, 0, 0, 1.0};
//+
Point(2) = {0.3, 0, 0, 1.0};
//+
Point(3) = {0.1, 0, 0, 1.0};
//+
Point(4) = {-0.1, 0, 0, 1.0};
//+
Point(5) = {-0.5, 0, 0, 1.0};
//+
Point(6) = {0.5, 0, 0, 1.0};
//+
Point(7) = {-2, -2, 0, 1.0};
//+
Point(8) = {2, -2, 0, 1.0};
//+
Point(9) = {2, 2, 0, 1.0};
//+
Point(10) = {-2, 2, 0, 1.0};
//+
Line(1) = {10, 7};
//+
Line(2) = {7, 8};
//+
Line(3) = {8, 9};
//+
Line(4) = {9, 10};
//+
Circle(5) = {5, 1, 4};
//+
Circle(6) = {4, 1, 5};
//+
Circle(7) = {3, 2, 6};
//+
Circle(8) = {6, 2, 3};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Curve Loop(2) = {5, 6};
//+
Curve Loop(3) = {7, 8};
//+
Plane Surface(1) = {1, 2, 3};
//+
Curve Loop(4) = {5, 6};
//+
Plane Surface(2) = {4};
//+
Curve Loop(5) = {7, 8};
//+
Plane Surface(3) = {5};
//+
Physical Curve("dirichlet") = {1, 4, 3, 2};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source1") = {2};
//+
Physical Surface("source2") = {3};
