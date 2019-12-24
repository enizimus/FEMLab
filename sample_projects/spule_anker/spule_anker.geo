// Gmsh project created on Fri Apr 12 20:45:35 2019
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
Point(5) = {0, 1.5, 0, 1.0};
//+
Point(6) = {0.6, 1.5, 0, 1.0};
//+
Point(7) = {0.6, 0, 0, 1.0};
//+
Point(8) = {0.5, 0, 0, 1.0};
//+
Point(9) = {0.3, 0, 0, 1.0};
//+
Point(10) = {0.3, 1.2, 0, 1.0};
//+
Point(11) = {0.5, 1.2, 0, 1.0};
//+
Line(1) = {1, 5};
//+
Line(2) = {5, 6};
//+
Line(3) = {6, 7};
//+
Line(4) = {7, 8};
//+
Line(5) = {8, 11};
//+
Line(6) = {11, 10};
//+
Line(7) = {10, 9};
//+
Line(8) = {9, 1};
//+
Line(9) = {9, 8};
//+
Line(10) = {7, 2};
//+
Line(11) = {2, 3};
//+
Line(12) = {3, 4};
//+
Line(13) = {4, 5};
//+
Curve Loop(1) = {10,11,12,13,2,3};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {2, 3, 4, 5, 6, 7, 8, 1};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {6, 7, 9, 5};
//+
Plane Surface(3) = {3};
//+
Physical Curve("dirichlet") = {1, 13, 12, 11, 10, 4, 9, 8};
//+
Physical Surface("air") = {1};
//+
Physical Surface("iron") = {2};
//+
Physical Surface("source") = {3};
