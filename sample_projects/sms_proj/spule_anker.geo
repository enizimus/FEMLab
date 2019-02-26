// Gmsh project created on Sun Feb 24 08:25:02 2019
//+
Point(1) = {-1, -1, 0, 1.0};
//+
Point(2) = {-1, 1, 0, 1.0};
//+
Point(3) = {0, 1, 0, 1.0};
//+
Point(4) = {2, 1, 0, 1.0};
//+
Point(5) = {0, -1, 0, 1.0};
//+
Point(6) = {2, -1, 0, 1.0};
//+
Point(7) = {0.5, -1, 0, 1.0};
//+
Point(8) = {0.5, 1, 0, 1.0};
//+
Point(9) = {0, 0.7, 0, 1.0};
//+
Point(10) = {0.5, 0.7, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 8};
//+
Line(4) = {8, 4};
//+
Line(5) = {4, 6};
//+
Line(6) = {6, 7};
//+
Line(7) = {7, 10};
//+
Line(8) = {10, 9};
//+
Line(9) = {9, 5};
//+
Line(10) = {5, 1};
//+
Line Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//+
Plane Surface(1) = {1};
//+
Line(11) = {5, 7};
//+
Line Loop(2) = {11, 7, 8, 9};
//+
Plane Surface(2) = {2};
//+
Physical Line("dirichlet") = {1};
//+
Physical Surface("iron") = {1};
//+
Physical Surface("source") = {2};
