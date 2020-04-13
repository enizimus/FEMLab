//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.002, 0, 0, 1.0};
//+
Point(3) = {0.002, 0.02, 0, 1.0};
//+
Point(4) = {0, 0.02, 0, 1.0};//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Physical Curve("outter_electrode") = {3};
//+
Physical Surface("medium") = {1};
