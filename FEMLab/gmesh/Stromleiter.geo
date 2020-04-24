//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1, 1, 0, 1.0};
//+
Point(3) = {0, 1, 0, 1.0};
//+
Point(4) = {1, 0, 0, 1.0};
//+
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.55, 0.5, 0, 1.0};
//+
Point(7) = {0.45, 0.5, 0, 1.0};
//+
Circle(1) = {7, 5, 6};
//+
Circle(2) = {6, 5, 7};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 4};
//+
Line(5) = {4, 1};
//+
Line(6) = {1, 3};
//+
Curve Loop(1) = {3, 4, 5, 6};
//+
Curve Loop(2) = {2, 1};
//+
Plane Surface(1) = {1, 2};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirichlet_boundary") = {3, 4, 5, 6};
//+
Physical Surface("air") = {1};
//+
Physical Surface("wire") = {2};
