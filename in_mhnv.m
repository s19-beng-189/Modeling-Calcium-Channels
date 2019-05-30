%filename: in_mhnv.m
%this script simulates holding the
%voltage constant for a long time
%prior to t=0 at the value v=vhold,
%and then applying a current shock
%at t=0 to step the voltage
%to a new level, v=vstart.
%The gating variables m,h,n
%cannot change suddenly and therefore
%remain constant during the current shock.
%
%simulate time prior to t=0:
v=vhold;
%initial Calcium Concentration
global Ca0;
%Ca0 = 5; %mM 1.1-1.35 is normal range of ionized Ca2+ in serum
%fraction of Na channels inhibited by calcium:
f = (0.4651*log((0.574*Ca0.^(0.4071))+0.2874))+0.2951;
f_shift = (0.4651*log((0.574*(1.2)^(0.4071))+0.2874))+0.2951;
%set m,h,n equal to their steady values
%under constant-v conditions:
m_Na=alpham(v)/(alpham(v)+betam(v))*(1-f);
m_Ca=alpham(v)/(alpham(v)+betam(v));
h=alphah(v)/(alphah(v)+betah(v));
n=alphan(v)/(alphan(v)+betan(v));
%
%now let voltage jump to its value
%just after t=0, without making
%any further change in m,h,n:
v=vstart;
