//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {10e-3, 0, 0, 1.0};
//+
Point(3) = {10e-3, 1e-3, 0, 1.0};
//+
Point(4) = {0, 1e-3, 0, 1.0};
//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
//+
Physical Curve("top_plate") = {4};
//+
Physical Curve("bottom_plate") = {2};
//+
Physical Surface("medium") = {1};
