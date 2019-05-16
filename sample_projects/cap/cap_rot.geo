// Gmsh project created on Thu May 16 17:05:50 2019
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
Point(5) = {0, 1.2, 0, 1.0};
//+
Point(6) = {0, 1.3, 0, 1.0};
//+
Point(7) = {0.6, 1.3, 0, 1.0};
//+
Point(8) = {0.6, 1.2, 0, 1.0};
//+
Point(9) = {0.6, 0.8, 0, 1.0};
//+
Point(10) = {0.6, 0.7, 0, 1.0};
//+
Point(11) = {0, 0.7, 0, 1.0};
//+
Point(12) = {0, 0.8, 0, 1.0};
//+
Line(1) = {4, 6};
//+
Line(2) = {6, 5};
//+
Line(3) = {5, 12};
//+
Line(4) = {12, 11};
//+
Line(5) = {11, 1};
//+
Line(6) = {1, 2};
//+
Line(7) = {2, 3};
//+
Line(8) = {3, 4};
//+
Line(9) = {6, 7};
//+
Line(10) = {7, 8};
//+
Line(11) = {8, 5};
//+
Line(12) = {12, 9};
//+
Line(13) = {9, 10};
//+
Line(14) = {10, 11};

//+
Curve Loop(1) = {1, 9, 10, 11, 3, 12, 13, 14, 5, 6, 7, 8};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {11, -2, 9, 10};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {12, 13, 14, -4};
//+
Plane Surface(3) = {3};
//+
Physical Curve("dirichlet") = {8, 7, 6};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source1") = {2};
//+
Physical Surface("source2") = {3};
