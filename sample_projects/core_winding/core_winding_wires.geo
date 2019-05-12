// Gmsh project created on Sat May 11 11:57:45 2019
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
Point(6) = {0.5, 1.5, 0, 1.0};
//+
Point(7) = {0.5, 1.25, 0, 1.0};
//+
Point(8) = {0.5, 1, 0, 1.0};
//+
Point(9) = {0.5, 0.75, 0, 1.0};
//+
Point(10) = {0.5, 0.5, 0, 1.0};

//+
Point(11) = {0, 1.75, 0, 1.0};
//+
Point(12) = {0, 0.25, 0, 1.0};
//+
Point(13) = {0.35, 0.25, 0, 1.0};
//+
Point(14) = {0.35, 1.75, 0, 1.0};
//+
Line(1) = {1, 12};
//+
Line(2) = {12, 11};
//+
Line(3) = {11, 4};
//+
Line(4) = {4, 3};
//+
Line(5) = {3, 2};
//+
Line(6) = {2, 1};
//+
Line(7) = {11, 14};
//+
Line(8) = {14, 13};
//+
Line(9) = {13, 12};
//+
Circle(10) = {0.5, 1.5, 0, 0.1, 0, 2*Pi};
//+
Circle(11) = {0.5, 1.25, 0, 0.1, 0, 2*Pi};
//+
Circle(12) = {0.5, 1, 0, 0.1, 0, 2*Pi};
//+
Circle(13) = {0.5, 0.75, 0, 0.1, 0, 2*Pi};
//+
Circle(14) = {0.5, 0.5, 0, 0.1, 0, 2*Pi};
//+
Curve Loop(1) = {4, 5, 6, 1, -9, -8, -7, 3};
//+
Curve Loop(2) = {10};
//+
Curve Loop(3) = {11};
//+
Curve Loop(4) = {12};
//+
Curve Loop(5) = {13};
//+
Curve Loop(6) = {14};
//+
Plane Surface(1) = {1, 2, 3, 4, 5, 6};
//+
Curve Loop(7) = {10};
//+
Plane Surface(2) = {7};
//+
Curve Loop(8) = {11};
//+
Plane Surface(3) = {8};
//+
Curve Loop(9) = {12};
//+
Plane Surface(4) = {9};
//+
Curve Loop(10) = {13};
//+
Plane Surface(5) = {10};
//+
Curve Loop(11) = {14};
//+
Plane Surface(6) = {11};
//+
Curve Loop(12) = {8, 9, 2, 7};
//+
Plane Surface(7) = {12};
//+
Physical Curve("dirichlet") = {2, 3, 1, 4, 5, 6};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2, 3, 4, 5, 6};
//+
Physical Surface("iron") = {7};
