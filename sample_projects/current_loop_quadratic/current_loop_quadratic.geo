//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 0, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {0, 2, 0, 1.0};
//+
Point(5) = {0.4, 1.1, 0, 1.0};
//+
Point(6) = {0.6, 1.1, 0, 1.0};
//+
Point(7) = {0.6, 0.9, 0, 1.0};
//+
Point(8) = {0.4, 0.9, 0, 1.0};
//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Line(5) = {5, 8};
//+
Line(6) = {8, 7};
//+
Line(7) = {7, 6};
//+
Line(8) = {6, 5};
//+
Curve Loop(1) = {8, 5, 6, 7};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {4, 1, 2, 3};
//+
Plane Surface(2) = {1, 2};
//+
Physical Curve("dirichlet_boundary") = {1, 4, 3, 2};
//+
Physical Surface("wire") = {1};
//+
Physical Surface("medium") = {2};
