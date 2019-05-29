%Best fit line with sample data
clc 
clf
ca0=[0 10 20 50];
fraction= [0 0.3 0.57 0.81];
f=-0.9164*exp(-0.046*ca0)+0.908; %goodness of fit line R^2 = 0.9859
plot(ca0,fraction, 'o')
hold on
plot(ca0,f)
title('Fraction of Ca-Blocked Na Channels Based on Ca2+ Concentration')
xlabel('Calcium Concentration')
ylabel('fraction of Ca blocked Na Channel')