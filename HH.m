%filename HH.m
%numerical solution of the space-clamped Hodgkin-Huxley equations
clear all
clc
close all
global check;
global t1p t2p ip Ca0; %parameters for the function izero(t)
in_HH;
in_mhnv;
%Original Action Potential
for klok=1:klokmax
  t=klok*dt;                      %note time
  m_Ca=snew(m_Ca,alpham(v),betam(v),dt); %update m
  h=snew(h,alphah(v),betah(v),dt); %update h
  n=snew(n,alphan(v),betan(v),dt); %update n
  gNa=gNabar*(m_Ca^3)*h;    %sodium conductance
  gK =gKbar*(n^4);    %potassium conductance
  g=gNa+gK+gLbar;         %total conductance
  gE=gNa*ENa+gK*EK+gLbar*EL;         %gE=g*E
  %save old value of v for checking purposes:
  v_old=v;
  %update v:
  v=(v+(dt/C)*(gE+izero(t)))/(1+(dt/C)*g);
  if(check)
    E=gE/g;
    chv=C*(v-v_old)/dt+g*(v-E)-izero(t);
  end
  %store results for future plotting:
  mhn_plot_O(:,klok)=[m_Ca h n]';
  g_plot(:,klok)=[gNa gK]';
  v_plot(klok)=v;
  t_plot(klok)=t;
end

in_mhnv
for klok=1:klokmax
  t=klok*dt;                      %note time
  m_Na=m_new(m_Na,alpham(v),betam(v),dt); %update m
  h=snew(h,alphah(v),betah(v),dt); %update h
  n=snew(n,alphan(v),betan(v),dt); %update n
  m_Ca=snew(m_Ca,alpham(v),betam(v),dt);
  gNa=gNabar*(m_Na^3)*h;    %sodium conductance
  gK =gKbar*(n^4);    %potassium conductance
  gCa = gCabar*(m_Ca^2); %calcium conductance
  g=gNa+gK+gLbar+gCa;         %total conductance
  gE=gNa*ENa+gK*EK+gLbar*EL+gCa*ECa;         %gE=g*E
  %save old value of v for checking purposes:
  v_old=v;
  %update v:
  v=(v+(dt/C)*(gE+izero(t)))/(1+(dt/C)*g);
  if(check)
    E=gE/g;
    chv=C*(v-v_old)/dt+g*(v-E)-izero(t);
  end
  %store results for future plotting:
  mmhn_plot(:,klok)=[m_Na h n m_Ca]';
  g_plotCa(:,klok)=[gNa gK gCa]';
  v_plotCa(klok)=v;
  t_plotCa(klok)=t;
end
figure(1)
hold on
plot(t_plot(1:100),v_plot(1:100),'LineWidth',2)
plot(t_plotCa(1:100),v_plotCa(1:100),'LineWidth',2)
title('Action Potential')
xlabel('Time (ms)')
ylabel('Voltage (mV)')
legend('Original HH Model','Ca2+ HH Model')

figure(2)
hold on
plot(t_plot,v_plot,'LineWidth',2)
plot(t_plotCa,v_plotCa,'LineWidth',2)
title('Action Potential Spike Train')
xlabel('Time (ms)')
ylabel('Voltage (mV)')
legend('Original HH Model','Ca2+ HH Model')

figure(3)
subplot(3,1,1)
hold on
plot(t_plot,g_plot(1,:),'LineWidth',2);
plot(t_plotCa,g_plotCa(1,:),'LineWidth',2);
title('Sodium Conductance');
legend('gNa with no Ca2+','gNa with Ca2+');
subplot(3,1,2)
hold on
plot(t_plot,g_plot(2,:),'LineWidth',2);
plot(t_plotCa,g_plotCa(2,:),'LineWidth',2);
title('Potassium Conductance');
legend('gK no with Ca2+','gK with Ca2+');
subplot(3,1,3)
hold on
plot(t_plotCa,g_plotCa(3,:),'LineWidth',2);
title('Calcium Conductance');

figure(4)
subplot(2,1,1)
hold on
plot(t_plot, mhn_plot_O(1,:), 'LineWidth', 2);
plot(t_plot, mhn_plot_O(2,:), 'LineWidth', 2);
plot(t_plot, mhn_plot_O(3,:), 'LineWidth', 2);
hold off
title('Original HH Model Gating Variable Over Time')
xlabel('Time (ms)')
ylabel('Probability of Open Gates')
legend('M Gates', 'H Gates', 'N Gates')
subplot(2,1,2)
hold on
plot(t_plotCa, mmhn_plot(1,:), 'LineWidth', 2);
plot(t_plotCa, mmhn_plot(2,:), 'LineWidth', 2);
plot(t_plotCa, mmhn_plot(3,:), 'LineWidth', 2);
plot(t_plotCa, mmhn_plot(4,:), 'LineWidth', 2);
hold off
title('New Calcium HH Model Gating Variable Over Time')
xlabel('Time (ms)')
ylabel('Probability of Open Gates')
legend('Na M Gates', 'H Gates', 'N Gates', 'Ca M Gates')
