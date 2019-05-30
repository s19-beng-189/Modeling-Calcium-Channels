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
  m=snew(m,alpham(v),betamCa(v,Ca0),dt); %update m
  h=snew(h,alphah(v),betah(v),dt); %update h
  n=snew(n,alphan(v),betan(v),dt); %update n
  mCa=snew(m,alpham(v),betam(v),dt);
  gNa=gNabar*(m^3)*h;    %sodium conductance
  gK =gKbar*(n^4);    %potassium conductance
  gCa = gCabar*(mCa^2);
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
hold on
plot(t_plot,v_plot,'LineWidth',1)
plot(t_plotCa,v_plotCa,'LineWidth',1)
title('Voltage vs. Time (no Ca2+)')
xlabel('Time (ms)')
ylabel('Voltage (mV)')
legend('No Ca2+','Ca2+')

figure(2)
subplot(3,1,1)
hold on
plot(t_plot,g_plot(1,:),'LineWidth',1);
plot(t_plotCa,g_plotCa(1,:),'LineWidth',1);
title('Sodium Conductance');
legend('gNa no Ca2+','gNa with Ca2+');
subplot(3,1,2)
hold on
plot(t_plot,g_plot(2,:),'LineWidth',1);
plot(t_plotCa,g_plotCa(2,:),'LineWidth',1);
title('Potassium Conductance');
legend('gK no Ca2+','gK with Ca2+');
subplot(3,1,3)
hold on
plot(t_plotCa,g_plotCa(3,:),'LineWidth',1);
title('Calcium Conductance');

