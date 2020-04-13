//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 2, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {2, 0, 0, 1.0};
//+
Point(8) = {0, 1, 0, 1.0};
//+
Point(9) = {0, 1.1, 0, 1.0};
//+
Point(10) = {0, 0.9, 0, 1.0};
//+
Line(1) = {2, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 1};
//+
Line(4) = {1, 10};
//+
Line(5) = {10, 8};
//+
Line(6) = {8, 9};
//+
Line(7) = {9, 2};
//+
Circle(8) = {10, 8, 9};
//+
Curve Loop(1) = {8, -6, -5};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {1, 2, 3, 4, 8, 7};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirichlet_boundary") = {1, 2, 3};
//+
Physical Surface("medium") = {2};
//+
Physical Surface("sphere") = {1};
