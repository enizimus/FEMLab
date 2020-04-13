//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 0.2, 0, 1.0};
//+
Point(3) = {0.2, 0.2, 0, 1.0};
//+
Point(4) = {0.2, 0, 0, 1.0};
//+
Point(5) = {0.01, 0.025, 0, 1.0};
//+
Point(6) = {0.01, 0.175, 0, 1.0};
//+
Point(7) = {0.012, 0.175, 0, 1.0};
//+
Point(8) = {0.012, 0.025, 0, 1.0};
//+
Point(9) = {0.017, 0.025, 0, 1.0};
//+
Point(10) = {0.017, 0.175, 0, 1.0};
//+
Point(11) = {0.019, 0.175, 0, 1.0};
//+
Point(12) = {0.019, 0.025, 0, 1.0};
//+
Line(1) = {6, 7};
//+
Line(2) = {7, 8};
//+
Line(3) = {8, 5};
//+
Line(4) = {5, 6};
//+
Line(5) = {10, 11};
//+
Line(6) = {11, 12};
//+
Line(7) = {12, 9};
//+
Line(8) = {9, 10};
//+
Line(9) = {2, 1};
//+
Line(10) = {1, 4};
//+
Line(11) = {4, 3};
//+
Line(12) = {3, 2};
//+
Curve Loop(1) = {2, 3, 4, 1};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {6, 7, 8, 5};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {12, 9, 10, 11};
//+
Plane Surface(3) = {1, 2, 3};
//+
Physical Curve("dirichlet_boundary") = {9, 12, 11, 10};
//+
Physical Curve("v_plus") = {2};
//+
Physical Curve("v_gnd") = {8};
//+
Physical Surface("plate") = {1, 2};
//+
Physical Surface("medium") = {3};
