// Gmsh project created on Sat Jul  4 19:33:28 2020
SetFactory("OpenCASCADE");

//+
Point(1) = {0, 1, 0, 1.0};
//+
Point(2) = {0, -1, 0, 1.0};
//+
Point(3) = {1, -1, 0, 1.0};
//+
Point(4) = {1, 1, 0, 1.0};
//+
Point(5) = {0.25, 0.25, 0, 0.05};
//+
Point(6) = {0.25, -0.25, 0, 0.05};
//+
Point(7) = {0.4, -0.25, 0, 0.05};
//+
Point(8) = {0.4, 0.25, 0, 0.05};
//+
Point(9) = {0, 0.5, 0, 1.0};
//+
Point(10) = {0, -0.5, 0, 1.0};
//+
Point(11) = {0.5, -0.5, 0, 0.1};
//+
Point(12) = {0.5, 0.5, 0, 0.1 };
//+
Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 10};
//+
Line(5) = {10, 9};
//+
Line(6) = {9, 1};
//+
Line(7) = {9, 12};
//+
Line(8) = {12, 11};
//+
Line(9) = {11, 10};
//+
Line(10) = {5, 8};
//+
Line(11) = {8, 7};
//+
Line(12) = {7, 6};
//+
Line(13) = {6, 5};
//+
Curve Loop(1) = {1, 2, 3, 4, 5, 6};
//+
Curve Loop(2) = {7, 8, 9, 5};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {7, 8, 9, 5};
//+
Curve Loop(4) = {10, 11, 12, 13};
//+
Plane Surface(2) = {3, 4};
//+
Curve Loop(5) = {10, 11, 12, 13};
//+
Plane Surface(3) = {5};
//+
Physical Curve("boundary") = {6, 2, 1, 5, 4, 3};
//+
Physical Surface("air") = {1};
//+
Physical Surface("iron") = {2};
//+
Physical Surface("source") = {3};
