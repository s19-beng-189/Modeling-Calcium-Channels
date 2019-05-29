%filename HH.m
%numerical solution of the space-clamped Hodgkin-Huxley equations
clear all
clf
global check;
global t1p t2p ip; %parameters for the function izero(t)
in_HH
in_mhnv
for klok=1:klokmax
  t=klok*dt;                      %note time
  m=snew(m,alpham(v),betam(v),dt); %update m
  h=snew(h,alphah(v),betah(v),dt); %update h
  n=snew(n,alphan(v),betan(v),dt); %update n
  gNa=gNabar*(m^3)*h;    %sodium conductance
  gK =gKbar*(n^4);    %potassium conductance
  g=gNa+gK+gLbar;         %total conductance
  gE=gNa*ENa+gK*EK+gLbar*EL;         %gE=g*E
  %save old value of v for checking purposes:
  v_old=v;
  %update v:
  v=(v+(dt/C)*(gE+izero(t)))/(1+(dt/C)*g);
  if(check)
    E=gE/g;
    chv=C*(v-v_old)/dt+g*(v-E)-izero(t)
  end
  %store results for future plotting:
  mhn_plot(:,klok)=[m h n]';
  g_plot(:,klok)=[gNa gK]';
  v_plot(klok)=v;
  t_plot(klok)=t;
end

in_mhnv
for klok=1:klokmax
  t=klok*dt;                      %note time
  m=snew(m,alpham(v),betam(v),dt); %update m
  h=snew(h,alphah(v),betah(v),dt); %update h
  n=snew(n,alphan(v),betan(v),dt); %update n
  gNa=gNabar*(m^3)*h;    %sodium conductance
  gK =gKbar*(n^4);    %potassium conductance
  gCa = gCabar*(m^2);
  g=gNa+gK+gLbar+gCa;         %total conductance
  gE=gNa*ENa+gK*EK+gLbar*EL+gCa*ECa;         %gE=g*E
  %save old value of v for checking purposes:
  v_old=v;
  %update v:
  v=(v+(dt/C)*(gE+izero(t)))/(1+(dt/C)*g);
  if(check)
    E=gE/g;
    chv=C*(v-v_old)/dt+g*(v-E)-izero(t)
  end
  %store results for future plotting:
  mhn_plot(:,klok)=[m h n]';
  g_plotCa(:,klok)=[gNa gK gCa]';
  v_plotCa(klok)=v;
  t_plotCa(klok)=t;
end
figure(1)
subplot(2,1,1)
hold on
plot(t_plot,v_plot)
plot(t_plotCa,v_plotCa)
title('Voltage vs. Time (no Ca2+)')
xlabel('Time (ms)')
ylabel('Voltage (mV)')
legend('No Ca2+','Ca2+')
subplot(2,1,2)
hold on
plot(t_plot,g_plot);
plot(t_plotCa,g_plotCa);
legend('gNa 1','gK1','gNa2','gK2','gCa');
