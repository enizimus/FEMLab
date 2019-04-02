// Gmsh project created on Mon Apr 01 21:26:49 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 2, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {2, 0, 0, 1.0};
//+
Point(5) = {0.3, 0, 0, 1.0};
//+
Point(6) = {0.3, 1.4, 0, 1.0};
//+
Point(7) = {0.5, 1.4, 0, 1.0};
//+
Point(8) = {0.5, 0, 0, 1.0};
//+
Point(9) = {0.75, 0, 0, 1.0};
//+
Point(10) = {0.75, 1.5, 0, 1.0};
//+
Point(11) = {0, 1.5, 0, 1.0};

//+
Line(1) = {2, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 9};
//+
Line(4) = {9, 10};
//+
Line(5) = {10, 11};
//+
Line(6) = {11, 2};
//+
Line(7) = {11, 1};
//+
Line(8) = {1, 5};
//+
Line(9) = {5, 6};
//+
Line(10) = {6, 7};
//+
Line(11) = {7, 8};
//+
Line(12) = {8, 5};
//+
Line(13) = {8, 9};

//+
Curve Loop(1) = {10, 11, 12, 9};
//+
Plane Surface(1) = {1};

//+
Curve Loop(2) = {5, 7, 8, 9, 10, 11, 13, 4};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {1, 2, 3, 4, 5, 6};
//+
Plane Surface(3) = {3};
//+
Physical Curve("dirichlet") = {6, 7};
//+
Physical Surface("iron") = {2};
//+
Physical Surface("source") = {1};
//+
Physical Surface("air") = {3};
