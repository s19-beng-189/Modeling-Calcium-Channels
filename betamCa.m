function b=betamCa(v,Ca0)
%filename: betam.m
if Ca0>=1.1
theta = (v+70)/18;
theta2 = -0.916*exp(-0.046*Ca0)+0.908;
b=4.0*exp(-theta) + theta2;
else 
    b=0.0239*Ca0+ 0.06236;
end
