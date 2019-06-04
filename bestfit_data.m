%Best fit line with sample data
clc 
clf
ca0=[0 0.2 2 10 20 50];
fraction= [0 0.05 0.3 0.57 0.68 0.81];
%Used Curve Fitting under Apps tab:
f=(0.4651*log((0.574*ca0.^(0.4071))+0.2874))+0.2951; %goodness of fit line R^2 = 0.9979
plot(ca0,fraction, 'o')
hold on
plot(ca0,f)
title('Fraction of Ca-Blocked Na Channels Based on Ca2+ Concentration')
xlabel('Calcium Concentration')
ylabel('fraction of Ca blocked Na Channel')