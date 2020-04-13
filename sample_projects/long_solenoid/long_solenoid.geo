//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 0.3, 0, 1.0};
//+
Point(3) = {0.3, 0.3, 0, 1.0};
//+
Point(4) = {0.3, 0, 0, 1.0};
//+
Point(5) = {0.03, 0.05, 0, 1.0};
//+
Point(6) = {0.05, 0.05, 0, 1.0};
//+
Point(7) = {0.05, 0.25, 0, 1.0};
//+
Point(8) = {0.03, 0.25, 0, 1.0};
//+
Line(1) = {2, 1};
//+
Line(2) = {1, 4};
//+
Line(3) = {4, 3};
//+
Line(4) = {3, 2};
//+
Line(5) = {8, 5};
//+
Line(6) = {5, 6};
//+
Line(7) = {6, 7};
//+
Line(8) = {7, 8};
//+
Curve Loop(1) = {8, 5, 6, 7};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {4, 1, 2, 3};
//+
Plane Surface(2) = {1, 2};
//+
Physical Curve("Dirichlet_Boundary") = {4, 3, 2};
//+
Physical Surface("Medium") = {2};
//+
Physical Surface("Solenoid") = {1};
