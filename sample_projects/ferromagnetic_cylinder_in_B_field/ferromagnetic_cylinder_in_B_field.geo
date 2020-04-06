//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 3, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {3, 0, 0, 1.0};
//+
Point(5) = {0, 0.75, 0, 1.0};
//+
Point(6) = {0.75, 0, 0, 1.0};
//+
Line(1) = {1, 6};
//+
Line(2) = {6, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Line(5) = {2, 5};
//+
Line(6) = {5, 1};
//+
Circle(7) = {5, 1, 6};
//+
Curve Loop(1) = {7, -1, -6};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {5, 7, 2, 3, 4};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirichlet_boundary") = {5,6};
//+
Physical Curve("surface_current") = {3};
//+
Physical Surface("medium") = {2};
//+
Physical Surface("cylinder") = {1};
