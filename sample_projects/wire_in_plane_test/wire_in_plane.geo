//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1, 0, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.52, 0.5, 0, 1.0};
//+
Point(7) = {0.48, 0.5, 0, 1.0};
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
Curve Loop(1) = {6, 5};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {4, 1, 2, 3};
//+
Plane Surface(2) = {1, 2};
//+
Physical Curve("Dirichlet_boundary") = {4, 3, 2, 1};
//+
Physical Surface("Medium") = {2};
//+
Physical Surface("Wire") = {1};
