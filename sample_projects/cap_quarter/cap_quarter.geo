//+
Point(1) = {0.5, 0, 0, 1.0};
//+
Point(2) = {1, 0, 0, 1.0};
//+
Point(3) = {0, 0.5, 0, 1.0};
//+
Point(4) = {0.5, 0.5, 0, 1.0};
//+
Point(5) = {0, 1, 0, 1.0};
//+
Circle(1) = {2, 4, 5};
//+
Line(2) = {5, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 1};
//+
Line(5) = {1, 2};
//+
Curve Loop(1) = {3, 4, 5, 1, 2};
//+
Plane Surface(1) = {1};
//+
Physical Curve("inner_electrode") = {3, 4};
//+
Physical Curve("outer_electrode") = {1};
//+
Physical Surface("medium") = {1};
