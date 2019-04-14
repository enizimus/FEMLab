// Gmsh project created on Sun Apr 14 11:51:40 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 2.5, 0, 1.0};
//+
Point(3) = {2.5, 2.5, 0, 1.0};
//+
Point(4) = {2.5, 0, 0, 1.0};
//+
Point(5) = {1, 1, 0, 1.0};
//+
Point(6) = {1.5, 1, 0, 1.0};
//+
Point(7) = {1.5, 1.1, 0, 1.0};
//+
Point(8) = {1, 1.1, 0, 1.0};
//+
Point(9) = {1, 1.3, 0, 1.0};
//+
Point(10) = {1, 1.4, 0, 1.0};
//+
Point(11) = {1.5, 1.4, 0, 1.0};
//+
Point(12) = {1.5, 1.3, 0, 1.0};
//+
Line(1) = {2, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 1};
//+
Line(4) = {1, 2};
//+
Line(5) = {10, 11};
//+
Line(6) = {11, 12};
//+
Line(7) = {12, 9};
//+
Line(8) = {9, 10};
//+
Line(9) = {8, 7};
//+
Line(10) = {7, 6};
//+
Line(11) = {6, 5};
//+
Line(12) = {5, 8};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {5, 6, 7, 8};
//+
Curve Loop(3) = {9, 10, 11, 12};
//+
Plane Surface(1) = {1, 2, 3};
//+
Curve Loop(4) = {5, 6, 7, 8};
//+
Plane Surface(2) = {4};
//+
Curve Loop(5) = {9, 10, 11, 12};
//+
Plane Surface(3) = {5};
//+
Physical Curve("dirichlet") = {1, 2, 3, 4};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source1") = {2};
//+
Physical Surface("source2") = {3};
