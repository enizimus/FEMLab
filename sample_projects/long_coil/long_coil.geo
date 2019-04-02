// Gmsh project created on Mon Apr 01 19:27:24 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.3, 0, 0, 1.0};
//+
Point(3) = {0.5, 0, 0, 1.0};
//+
Point(4) = {2, 0, 0, 1.0};
//+
Point(5) = {2, 2, 0, 1.0};

//+
Point(6) = {0.5, 2, 0, 1.0};
//+
Point(7) = {0.3, 2, 0, 1.0};
//+
Point(8) = {0, 2, 0, 1.0};
//+
Line(1) = {8, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 7};
//+
Line(4) = {7, 8};
//+
Line(5) = {7, 6};
//+
Line(6) = {6, 3};
//+
Line(7) = {3, 2};
//+
Line(8) = {3, 4};
//+
Line(9) = {4, 5};
//+
Line(10) = {5, 6};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {10, 6, 8, 9};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {6, 7, 3, 5};
//+
Plane Surface(3) = {3};

//+
Physical Curve("dirichlet") = {1};
//+
Physical Surface("air") = {1, 2};
//+
Physical Surface("source") = {3};
//+
Physical Curve("dirichlet") += {10, 5, 4, 9, 8, 7, 2};
