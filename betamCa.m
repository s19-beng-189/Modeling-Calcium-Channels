function b=betamCa(v,Ca0)
%filename: betam.m
theta = (v+70)/18;
theta2 = (0.4651*log((0.574*Ca0.^(0.4071))+0.2874))+0.2951;
b=4.0*exp(-theta) + theta2;
end
