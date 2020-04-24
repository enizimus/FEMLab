//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 3, 0, 1.0};
//+
Point(3) = {3, 3, 0, 1.0};
//+
Point(4) = {3, 0, 0, 1.0};
//+
Point(5) = {0, 1.6, 0, 1.0};
//+
Point(6) = {0, 1.4, 0, 1.0};
//+
Point(7) = {0, 1.35, 0, 1.0};
//+
Point(8) = {0, 1.65, 0, 1.0};
//+
Point(9) = {0.6, 1.65, 0, 1.0};
//+
Point(10) = {0.6, 1.6, 0, 1.0};
//+
Point(11) = {0.6, 1.4, 0, 1.0};
//+
Point(12) = {0.6, 1.35, 0, 1.0};
//+
Line(1) = {2, 8};
//+
Line(2) = {8, 5};
//+
Line(3) = {5, 6};
//+
Line(4) = {6, 7};
//+
Line(5) = {7, 1};
//+
Line(6) = {1, 4};
//+
Line(7) = {4, 3};
//+
Line(8) = {3, 2};
//+
Line(9) = {8, 9};
//+
Line(10) = {9, 10};
//+
Line(11) = {10, 5};
//+
Line(12) = {6, 11};
//+
Line(13) = {12, 11};
//+
Line(14) = {12, 7};
//+
Curve Loop(1) = {9, 10, 11, -2};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {12, -13, 14, -4};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {8, 1, 9, 10, 11, 3, 12, -13, 14, 5, 6, 7};
//+
Plane Surface(3) = {3};
//+
Physical Curve("dirichlet_boundary") = {1, 2, 3, 4, 5};
//+
Physical Curve("surface_charge_1") = {11};
//+
Physical Curve("surface_charge_2") = {12};
//+
Physical Surface("cap_plate_1") = {1};
//+
Physical Surface("cap_plate_2") = {2};
//+
Physical Surface("medium") = {3};
