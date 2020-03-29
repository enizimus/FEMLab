//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 0.001, 0, 1.0};
//+
Point(3) = {0.01, 0.001, 0, 1.0};
//+
Point(4) = {0.01, 0, 0, 1.0};//+
Line(1) = {2, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
//+
Physical Curve("Vplus") = {4};
//+
Physical Curve("Vgnd") = {2};
//+
Physical Surface("Medium") = {1};
