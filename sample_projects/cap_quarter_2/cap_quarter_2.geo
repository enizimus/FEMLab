//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 0.5, 0, 1.0};
//+
Point(3) = {0, 1, 0, 1.0};
//+
Point(4) = {0.5, 0, 0, 1.0};
//+
Point(5) = {1, 0, 0, 1.0};
//+
Point(6) = {0.5, 0.5, 0, 1.0};
//+
Line(1) = {3, 2};
//+
Line(2) = {2, 1};
//+
Line(3) = {1, 4};
//+
Line(4) = {4, 5};
//+
Line(5) = {4, 6};
//+
Line(6) = {6, 2};
//+
Circle(7) = {3, 1, 5};
//+
Curve Loop(1) = {7, -4, 5, 6, -1};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {6, 2, 3, 5};
//+
Plane Surface(2) = {2};
//+
Physical Curve("inner_electrode") = {6, 5};
//+
Physical Curve("outer_electrode") = {7};
//+
Physical Surface("medium") = {1, 2};
