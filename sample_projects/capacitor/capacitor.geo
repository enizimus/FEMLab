//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1e-2, 0, 0, 1.0};
//+
Point(3) = {0, 0.001, 0, 1.0};
//+
Point(4) = {0.01, 0.001, 0, 1.0};
//+
Line(1) = {3, 4};
//+
Line(2) = {4, 2};
//+
Line(3) = {2, 1};
//+
Line(4) = {1, 3};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Physical Curve("V_plus") = {1};
//+
Physical Curve("V_gnd") = {3};
//+
Physical Surface("medium") = {1};
