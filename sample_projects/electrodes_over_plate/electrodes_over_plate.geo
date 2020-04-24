//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 0, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {0, 2, 0, 1.0};
//+
Point(5) = {1, 1, 0, 1.0};
//+
Point(6) = {0.5, 1, 0, 1.0};
//+
Point(7) = {0.55, 1, 0, 1.0};
//+
Point(8) = {0.45, 1, 0, 1.0};
//+
Point(9) = {0.95, 1, 0, 1.0};
//+
Point(10) = {1.05, 1, 0, 1.0};
//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Circle(5) = {8, 6, 7};
//+
Circle(6) = {7, 6, 8};
//+
Circle(7) = {9, 5, 10};
//+
Circle(8) = {10, 5, 9};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Curve Loop(2) = {8, 7};
//+
Curve Loop(3) = {6, 5};
//+
Plane Surface(1) = {1, 2, 3};
//+
Plane Surface(2) = {3};
//+
Plane Surface(3) = {2};
//+
Physical Curve("symmetry_axis") = {1};
//+
Physical Curve("dirichlet_boundary") = {4, 3, 2};
//+
Physical Surface("cylinder1") = {2};
//+
Physical Surface("cylinder2") = {3};
//+
Physical Surface("medium") = {1};
