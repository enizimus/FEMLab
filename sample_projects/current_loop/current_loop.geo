//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 2, 0, 1.0};
//+
Point(3) = {0, 2, 0, 1.0};
//+
Point(4) = {2, 0, 0, 1.0};
//+
Point(5) = {0.5, 1, 0, 1.0};
//+
Point(6) = {0.6, 1, 0, 1.0};
//+
Point(7) = {0.4, 1, 0, 1.0};
//+
Line(1) = {3, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 2};
//+
Line(4) = {2, 3};
//+
Circle(5) = {7, 5, 6};
//+
Circle(6) = {6, 5, 7};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Curve Loop(2) = {6, 5};
//+
Plane Surface(1) = {1, 2};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirichlet_boundary") = {4, 3, 2};
//+
Physical Surface("wire") = {2};
//+
Physical Surface("medium") = {1};
