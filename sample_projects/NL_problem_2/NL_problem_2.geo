//+
Point(1) = {0, 1, 0, 1.0};
//+
Point(2) = {0, -1, 0, 1.0};
//+
Point(3) = {1, -1, 0, 1.0};
//+
Point(4) = {1, 1, 0, 1.0};
//+
Point(5) = {0.85, 0.75, 0, 1.0};
//+
Point(6) = {0.85, -0.75, 0, 1.0};
//+
Point(7) = {0.25, -0.75, 0, 1.0};
//+
Point(8) = {0.25, 0.75, 0, 1.0};
//+
Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 1};
//+
Line(5) = {8, 5};
//+
Line(6) = {5, 6};
//+
Line(7) = {6, 7};
//+
Line(8) = {7, 8};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {5, 6, 7, 8};
//+
Plane Surface(1) = {1, 2};
//+
Plane Surface(2) = {2};
//+
Physical Curve("dirRb") = {1, 2, 4, 3};
//+
Physical Surface("iron") = {1};
//+
Physical Surface("source") = {2};
