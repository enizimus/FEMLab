//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1, 0, 0, 1.0};
//+
Point(3) = {1, 1, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Point(5) = {0.25, 0.75, 0, 1.0};
//+
Point(6) = {0.3, 0.75, 0, 1.0};
//+
Point(7) = {0.2, 0.75, 0, 1.0};
//+
Point(8) = {0.2, 0.25, 0, 1.0};
//+
Point(9) = {0.25, 0.25, 0, 1.0};
//+
Point(10) = {0.3, 0.25, 0, 1.0};
//+
Point(12) = {0.7, 0.25, 0, 1.0};
//+
Point(13) = {0.75, 0.25, 0, 1.0};
//+
Point(14) = {0.8, 0.25, 0, 1.0};
//+
Point(15) = {0.8, 0.75, 0, 1.0};
//+
Point(16) = {0.75, 0.75, 0, 1.0};
//+
Point(17) = {0.7, 0.75, 0, 1.0};
//+
Circle(1) = {7, 5, 6};
//+
Circle(2) = {6, 5, 7};
//+
Circle(3) = {17, 16, 15};
//+
Circle(4) = {15, 16, 17};
//+
Circle(5) = {8, 9, 10};
//+
Circle(6) = {10, 9, 8};
//+
Circle(7) = {12, 13, 14};
//+
Circle(8) = {14, 13, 12};
//+
Line(9) = {4, 1};
//+
Line(10) = {1, 2};
//+
Line(11) = {2, 3};
//+
Line(12) = {3, 4};
//+
Curve Loop(1) = {12, 9, 10, 11};
//+
Curve Loop(2) = {2, 1};
//+
Curve Loop(3) = {4, 3};
//+
Curve Loop(4) = {8, 7};
//+
Curve Loop(5) = {6, 5};
//+
Plane Surface(1) = {1, 2, 3, 4, 5};
//+
Plane Surface(2) = {2};
//+
Plane Surface(3) = {3};
//+
Plane Surface(4) = {4};
//+
Plane Surface(5) = {5};
//+
Physical Curve("dirichlet") = {9, 12, 11, 10};
//+
Physical Surface("source1") = {2, 4};
//+
Physical Surface("source2") = {5, 3};
//+
Physical Surface("air") = {1};
