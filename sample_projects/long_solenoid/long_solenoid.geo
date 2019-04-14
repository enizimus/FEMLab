// Gmsh project created on Wed Apr 03 20:44:38 2019
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
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.3, 0.5, 0, 1.0};
//+
Point(7) = {0.3, 2.5, 0, 1.0};
//+
Point(8) = {0.5, 2.5, 0, 1.0};

//+
Line(1) = {7, 6};
//+
Line(2) = {6, 5};
//+
Line(3) = {5, 8};
//+
Line(4) = {8, 7};
//+
Line(5) = {2, 1};
//+
Line(6) = {1, 4};
//+
Line(7) = {4, 3};
//+
Line(8) = {3, 2};

//+
Curve Loop(1) = {8, 5, 6, 7};
//+
Curve Loop(2) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1, 2};
//+
Curve Loop(3) = {4, 1, 2, 3};
//+
Plane Surface(2) = {3};
//+
Physical Curve("dirichlet") = {8, 5, 6, 7};
//+
Physical Surface("air") = {1};
//+
Physical Surface("source") = {2};
