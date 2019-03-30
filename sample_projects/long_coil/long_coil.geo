// Gmsh project created on Fri Mar 29 21:16:55 2019
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0 , 0, 0, 2, 2, 0};
//+
Rectangle(2) = {0.3, 0.01, 0, 0.2, 1.98, 0};
//+
Curve Loop(3) = {3, 4, 1, 2};
//+
Curve Loop(4) = {6, 7, 8, 5};
//+
Plane Surface(3) = {3, 4};
//+
Plane Surface(4) = {5};
