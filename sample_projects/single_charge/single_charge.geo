// Gmsh project created on Sat Apr 13 10:07:46 2019
SetFactory("OpenCASCADE");
//+
Point(1) = {-1, -1, 0, 1.0};
//+
Point(2) = {1, -1, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {-1, 1, 0, 1.0};
//+
Point(5) = {-0.2, 0, 0, 1.0};
//+
Point(6) = {-0.15, 0, 0, 1.0};
//+
Point(7) = {-0.25, 0, 0, 1.0};
//+
Point(8) = {0.2, 0, 0, 1.0};
//+
Point(9) = {0.15, 0, 0, 1.0};
//+
Point(10) = {0.25, 0, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 4};

//+
Circle(5) = {7, 5, 6};
//+
Circle(6) = {6, 5, 7};
//+
Circle(7) = {9, 8, 10};
//+
Circle(8) = {10, 8, 9};
//+
Curve Loop(1) = {1, 2, 3, 4};
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
Physical Curve("dirichlet") = {4, 1, 2, 3};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source1") = {2};
//+
Physical Surface("source2") = {3};
