%filename: in_HH.m
%Units:
%voltage is in millivolts (mV)
%current is in microamperes (muA)
%length is in centimeters (cm)
%time is in milliseconds (ms)
%note that microfarads =
%microamperes*milliseconds/millivolt
%= muA*ms/mV
%
%initialize membrane parameters:
%membrane capacitance per unit area:
C=1.0      %(muF/cm^2)
%
traub_parameters
%
%initialize time step and experiment duration:
dt=0.1     %time step duration (ms)
tmax=50    %duration of experiment (ms)
%total number of time steps in the experiment:
klokmax=ceil(tmax/dt)
%
%initialize arrays that hold data for plotting:
mhn_plot=zeros(3,klokmax);
v_plot=zeros(1,klokmax);
t_plot=zeros(1,klokmax);
%
%initialize parameters that define the experiment:
%the neuron is at rest (v= -70 mV) prior to t=0;
%at t=0 a current shock is applied after which v= -55 mV;
%then a subsequent 15 muA current pulse of 1 ms duration
%is applied beginning at t=10 ms.
%voltage prior to t=0:
vhold=  -70  %(mV)
%voltage just after t=0:
vstart= -70  %(mV)
%(change in v is result of current shock applied at t=0)
%
%initialize parameters of subsequent current pulse:
t1p=0       %starting time (ms)
t2p=tmax       %stopping time (ms)
ip=1        %current applied (muA)
%
%initialize checking parameter
check=1      %set check=1 to enable self-checking
             %set check=0 to disable self-checking
