%Best fit line with sample data
clc 
clf
ca0=[0 1 10];
fraction= [0.05 .1 0.3];
f=0.0239*ca0+ 0.06236; %goodness of fit line R^2 = 0.9804
figure 
hold on
plot(ca0,fraction, 'o')
plot(ca0,f,'r')
title('Fraction of Ca-Blocked Na Channels Based on Ca2+ Concentration')
xlabel('Calcium Concentration')
ylabel('fraction of Ca blocked Na Channel')