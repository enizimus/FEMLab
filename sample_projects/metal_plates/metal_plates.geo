//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1, 0, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.5, 0, 0, 1.0};
//+
Point(7) = {0, 0.5, 0, 1.0};
//+
Line(1) = {4, 7};
//+
Line(2) = {7, 5};
//+
Line(3) = {5, 6};
//+
Line(4) = {6, 2};
//+
Circle(5) = {4, 1, 2};
//+
Curve Loop(1) = {5, -4, -3, -2, -1};
//+
Plane Surface(1) = {1};
//+
Physical Curve("top_plate") = {1};
//+
Physical Curve("bottom_plate") = {3};
//+
Physical Surface("medium") = {1};
