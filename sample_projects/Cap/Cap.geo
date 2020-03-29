//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 1, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {1, 0, 0, 1.0};
//+
Point(5) = {0.35, 0.55, 0, 1.0};
//+
Point(6) = {0.65, 0.55, 0, 1.0};
//+
Point(7) = {0.65, 0.57, 0, 1.0};
//+
Point(8) = {0.35, 0.57, 0, 1.0};
//+
Point(9) = {0.35, 0.45, 0, 1.0};
//+
Point(10) = {0.35, 0.43, 0, 1.0};
//+
Point(11) = {0.65, 0.43, 0, 1.0};
//+
Point(12) = {0.65, 0.45, 0, 1.0};
//+
Line(1) = {2, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 1};
//+
Line(4) = {1, 2};
//+
Line(5) = {8, 5};
//+
Line(6) = {5, 6};
//+
Line(7) = {6, 7};
//+
Line(8) = {7, 8};
//+
Line(9) = {9, 10};
//+
Line(10) = {10, 11};
//+
Line(11) = {11, 12};
//+
Line(12) = {12, 9};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Curve Loop(2) = {8, 5, 6, 7};
//+
Curve Loop(3) = {12, 9, 10, 11};
//+
Plane Surface(1) = {1, 2, 3};
//+
Plane Surface(2) = {2};
//+
Plane Surface(3) = {3};
//+
Physical Curve("Dirichlet_Boundary") = {1, 2, 3, 4};
//+
Physical Surface("Air") = {1};
//+
Physical Surface("Electrode_1") = {2};
//+
Physical Surface("Electrode_2") = {3};
