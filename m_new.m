function s=m_new(s_old,alpha,beta,dt)
%filename: snew.m
global check;
%initial Calcium Concentration
Ca0 = 5; %mM 1.1-1.35 is normal range of ionized Ca2+ in serum
%fraction of Na channels inhibited by calcium:
f = (0.4651*log((0.574*Ca0.^(0.4071))+0.2874))+0.2951;
f_shift = (0.4651*log((0.574*(1.2)^(0.4071))+0.2874))+0.2951;

%calculating new probability:
s=(s_old+(dt*alpha*(1+f_shift-f)))/(1+dt*(alpha+beta));
if(check)
  chsnew=(s-s_old)/dt-(alpha*(1-s)-beta*s);
end
