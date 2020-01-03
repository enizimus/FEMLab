//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 1, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {1, 0, 0, 1.0};
//+
Point(5) = {0.5, 0.5, 0, 1.0};
//+
Point(6) = {0.5, 0.6, 0, 1.0};
//+
Point(7) = {0.5, 0.4, 0, 1.0};
//+
Line(1) = {2, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Circle(5) = {6, 5, 7};
//+
Circle(6) = {7, 5, 6};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Curve Loop(2) = {6, 5};
//+
Plane Surface(1) = {1, 2};
//+
Plane Surface(2) = {2};
//+
Physical Curve("diri") = {2, 1, 4};
//+
Physical Surface("airi") = {1};
//+
Physical Surface("souri") = {2};
