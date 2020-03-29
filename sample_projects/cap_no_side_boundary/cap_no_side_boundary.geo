//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1e-2, 0, 0, 1.0};
//+
Point(3) = {1e-2, 1e-3, 0, 1.0};
//+
Point(4) = {0, 1e-3, 0, 1.0};
//+
Point(5) = {0, 0.8e-3, 0, 1.0};
//+
Point(6) = {0, 0.2e-3, 0, 1.0};
//+
Point(7) = {0.01, 0.2e-3, 0, 1.0};
//+
Point(8) = {0.01, 0.8e-3, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 8};
//+
Line(3) = {8, 7};
//+
Line(4) = {7, 2};
//+
Line(5) = {2, 1};
//+
Line(6) = {1, 6};
//+
Line(7) = {6, 5};
//+
Line(8) = {5, 4};
//+
Line(9) = {5, 8};
//+
Line(10) = {7, 6};
//+
Curve Loop(1) = {9, -2, -1, -8};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {10, -6, -5, -4};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {9, 3, 10, 7};
//+
Plane Surface(3) = {3};
//+
Physical Surface("Qplus") = {1};
//+
Physical Surface("Qminus") = {2};
//+
Physical Surface("Medium") = {3};
