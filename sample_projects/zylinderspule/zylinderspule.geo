// Gmsh project created on Mon May 20 01:10:27 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 3, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {3, 0, 0, 1.0};
//+
Circle(5) = {0.5, 1.65, 0, 0.1, 0, 2*Pi};
//+
Circle(6) = {0.5, 1.95, 0, 0.1, 0, 2*Pi};
//+
Circle(7) = {0.5, 2.25, 0, 0.1, 0, 2*Pi};
//+
Circle(8) = {0.5, 1.35, 0, 0.1, 0, 2*Pi};
//+
Circle(9) = {0.5, 1.05, 0, 0.1, 0, 2*Pi};
//+
Circle(10) = {0.5, 0.75, 0, 0.1, 0, 2*Pi};
//+
Point(11) = {0, 2.6, 0, 1.0};
//+
Point(12) = {0.35, 2.6, 0, 1.0};
//+
Point(13) = {0.35, 0.4, 0, 1.0};
//+
Point(14) = {0, 0.4, 0, 1.0};
//+
Line(11) = {1, 14};
//+
Line(12) = {14, 11};
//+
Line(13) = {11, 2};
//+
Line(14) = {2, 3};
//+
Line(15) = {3, 4};
//+
Line(16) = {4, 1};
//+
Line(17) = {14, 13};
//+
Line(18) = {13, 12};
//+
Line(19) = {12, 11};
//+
Curve Loop(1) = {14, 15, 16, 11, 17, 18, 19, 13};
//+
Curve Loop(2) = {7};
//+
Curve Loop(3) = {6};
//+
Curve Loop(4) = {5};
//+
Curve Loop(5) = {8};
//+
Curve Loop(6) = {9};
//+
Curve Loop(7) = {10};
//+
Plane Surface(1) = {1, 2, 3, 4, 5, 6, 7};
//+
Curve Loop(8) = {7};
//+
Plane Surface(2) = {8};
//+
Curve Loop(9) = {6};
//+
Plane Surface(3) = {9};
//+
Curve Loop(10) = {5};
//+
Plane Surface(4) = {10};
//+
Curve Loop(11) = {8};
//+
Plane Surface(5) = {11};
//+
Curve Loop(12) = {9};
//+
Plane Surface(6) = {12};
//+
Curve Loop(13) = {10};
//+
Plane Surface(7) = {13};
//+
Curve Loop(14) = {19, -12, 17, 18};
//+
Plane Surface(8) = {14};
//+
Physical Curve("dirichlet") = {12, 13, 14, 15, 16, 11};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2, 3, 4, 5, 6, 7};
//+
Physical Surface("iron") = {8};
