//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {3, 3, 0, 1.0};
//+
Point(3) = {-3, -3, 0, 1.0};
//+
Point(4) = {-3, 3, 0, 1.0};
//+
Point(5) = {3, -3, 0, 1.0};//+
Point(6) = {0.3, 0, 0, 1.0};
//+
Point(7) = {-0.3, 0, 0, 1.0};
//+
Line(1) = {4, 3};
//+
Line(2) = {3, 5};
//+
Line(3) = {5, 2};
//+
Line(4) = {2, 4};
//+
Circle(5) = {7, 1, 6};
//+
Circle(6) = {6, 1, 7};
//+
Curve Loop(1) = {6, 5};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {4, 1, 2, 3};
//+
Plane Surface(2) = {1, 2};
//+
Physical Curve("Dirichlet_Boundary") = {1, 4, 3, 2};
//+
Physical Surface("Medium") = {2};
//+
Physical Surface("Charged_Sphere") = {1};
