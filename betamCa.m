function b=betamCa(v,Ca0)
%filename: betam.m
theta = (v+70)/18;
theta2 = -0.916*exp(-0.046*Ca0)+0.908;
b=4.0*exp(-theta) + theta2;
