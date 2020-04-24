//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {2, 0, 0, 1.0};
//+
Point(3) = {2, 2, 0, 1.0};
//+
Point(4) = {0, 2, 0, 1.0};
//+
Point(5) = {0, 0.5, 0, 1.0};
//+
Point(6) = {0, 1, 0, 1.0};
//+
Point(7) = {0, 1.1, 0, 1.0};
//+
Point(8) = {0, 0.9, 0, 1.0};
//+
Point(9) = {0, 0.6, 0, 1.0};
//+
Point(10) = {0, 0.4, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 10};
//+
Line(5) = {10, 5};
//+
Line(6) = {5, 9};
//+
Line(7) = {9, 8};
//+
Line(8) = {8, 6};
//+
Line(9) = {6, 7};
//+
Line(10) = {7, 4};
//+
Circle(11) = {10, 5, 9};
//+
Circle(12) = {8, 6, 7};
//+
Curve Loop(1) = {12, -9, -8};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {11, -6, -5};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {1, 2, 3, 4, 11, 7, 12, 10};
//+
Plane Surface(3) = {3};
//+
Physical Curve("dirichlet_boundary") = {1, 2};
//+
Physical Surface("sphere1") = {1};
//+
Physical Surface("sphere2") = {2};
//+
Physical Surface("medium") = {3};
