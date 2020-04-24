//+
Point(1) = {-0.25, 0, 0, 1.0};
//+
Point(2) = {-0.25, 0.3, 0, 1.0};
//+
Point(3) = {0.25, 0.3, 0, 1.0};
//+
Point(4) = {0.25, 0, 0, 1.0};
//+
Point(5) = {-0.05, 0.15, 0, 1.0};
//+
Point(6) = {-0.03, 0.15, 0, 1.0};
//+
Point(7) = {-0.07, 0.15, 0, 1.0};
//+
Point(8) = {0.07, 0.15, 0, 1.0};
//+
Point(9) = {0.05, 0.15, 0, 1.0};
//+
Point(10) = {0.03, 0.15, 0, 1.0};
//+
Circle(1) = {7, 5, 6};
//+
Circle(2) = {6, 5, 7};
//+
Circle(3) = {10, 9, 8};
//+
Circle(4) = {8, 9, 10};
//+
Line(5) = {2, 1};
//+
Line(6) = {1, 4};
//+
Line(7) = {4, 3};
//+
Line(8) = {3, 2};
//+
Curve Loop(1) = {8, 5, 6, 7};
//+
Curve Loop(2) = {4, 3};
//+
Curve Loop(3) = {2, 1};
//+
Plane Surface(1) = {1, 2, 3};
//+
Plane Surface(2) = {3};
//+
Plane Surface(3) = {2};
//+
Physical Curve("far_boundary") = {8, 7, 6, 5};
//+
Physical Surface("medium") = {1};
//+
Physical Surface("cylinder1") = {2};
//+
Physical Surface("cylinder2") = {3};
