//+
Point(1) = {-3, -3, 0, 1.0};
//+
Point(2) = {3, -3, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {-3, 3, 0, 1.0};
//+
Point(5) = {0, 0, 0, 1.0};
//+
Point(6) = {0.1, 0, 0, 1.0};
//+
Point(7) = {-0.1, 0, 0, 1.0};
//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
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
Physical Curve("dirichlet_boundary") = {1};
//+
Physical Surface("medium") = {1};
//+
Physical Surface("cylinder") = {2};
