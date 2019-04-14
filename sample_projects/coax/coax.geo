// Gmsh project created on Sun Apr 14 12:11:56 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {3, 0, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {0, 3, 0, 1.0};
//+
Point(5) = {1.5, 1.5, 0, 1.0};
//+
Point(6) = {1.4, 1.5, 0, 1.0};
//+
Point(7) = {1.6, 1.5, 0, 1.0};
//+
Point(8) = {1.8, 1.5, 0, 1.0};
//+
Point(9) = {1.2, 1.5, 0, 1.0};
//+
Point(10) = {1.15, 1.5, 0, 1.0};
//+
Point(11) = {1.85, 1.5, 0, 1.0};
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
Circle(7) = {9, 5, 8};
//+
Circle(8) = {8, 5, 9};
//+
Circle(9) = {10, 5, 11};
//+
Circle(10) = {11, 5, 10};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {9, 10};
//+
Curve Loop(3) = {7, 8};
//+
Curve Loop(4) = {5, 6};
//+
Plane Surface(1) = {1, 2, 3, 4};
//+
Curve Loop(5) = {9, 10};
//+
Curve Loop(6) = {7, 8};
//+
Curve Loop(7) = {5, 6};
//+
Plane Surface(2) = {5, 6, 7};
//+
Curve Loop(8) = {7, 8};
//+
Curve Loop(9) = {5, 6};
//+
Plane Surface(3) = {8, 9};
//+
Curve Loop(10) = {5, 6};
//+
Plane Surface(4) = {10};
//+
Physical Curve("dirichlet") = {1, 2, 3, 4};
//+
Physical Surface("air") = {1, 3};
//+
Physical Surface("source1") = {4};
//+
Physical Surface("iron") = {2};
