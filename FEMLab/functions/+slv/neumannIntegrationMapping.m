function w = neumannIntegrationMapping(iPt, u, gData)

z2 = gData(iPt,1);
z3 = gData(iPt,2);
z1 = 1-z2-z3;

q = [z1*(2*z1-1); z2*(2*z2-1); z3*(2*z3-1);
    4*z1*z2;      4*z2*z3;    4*z1*z3];

w = u*q;