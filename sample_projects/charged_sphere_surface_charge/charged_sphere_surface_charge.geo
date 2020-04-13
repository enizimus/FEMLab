//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 0, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {0, 2, 0, 1.0};
//+
Point(5) = {0, 1, 0, 1.0};
//+
Point(6) = {0, 1.1, 0, 1.0};
//+
Point(7) = {0, 0.9, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 7};
//+
Line(5) = {7, 5};
//+
Line(6) = {5, 6};
//+
Line(7) = {6, 4};
//+
Circle(8) = {7, 5, 6};
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
Physical Curve("surface_charge") = {8};
//+
Physical Surface("sphere") = {1};
//+
Physical Surface("medium") = {2};
