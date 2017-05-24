function [ result ] = TH( event,dir )


% TH - Time Headway, velocity of own vehicle divided in corelation with position of event vehicle.
%Speed of the vehicule - velX
%Distance to event vehicule - eventVehDist

load (dir,'SS_VDM_velX')         %Speed of the vehicule - velX
load (dir,'SS_VDM_eventVehVelX')         %Speed of event vehicule - eventVehVelX
load (dir,'SS_VDM_eventVehDist')         %Distance to event vehicule - eventVehDist

fs=50;
low=1;
high=0.1;
t=SS_VDM_velX.TimeAxis.Data;
Data1=SS_VDM_velX.Data;
Data2=SS_VDM_eventVehVelX.Data;
Data3=SS_VDM_eventVehDist.Data;

[Data1,idx]=get_event_signals(Data1, t, event);
[Data3,idx]=get_event_signals(Data3, t, event);

WinSize=100;


t1=t(idx(1,1):idx(1,2));              t2=t(idx(2,1):idx(2,2));              t3=t(idx(3,1):idx(3,2));              t4=t(idx(4,1):idx(4,2));

Data11 = Data1(idx(1,1):idx(1,2));    Data12 = Data1(idx(2,1):idx(2,2));    Data13 = Data1(idx(3,1):idx(3,2));    Data14 = Data1(idx(4,1):idx(4,2));

Data31 = Data3(idx(1,1):idx(1,2));    Data32 = Data3(idx(2,1):idx(2,2));    Data33 = Data3(idx(3,1):idx(3,2));    Data34 = Data3(idx(4,1):idx(4,2));


% TH - dist to lead / own vehicule speed

TH1 = Data31/(Data11);
TH2 = Data32/(Data12);
TH3 = Data33/(Data13);
TH4 = Data34/(Data14);

% Features
% Average Time Headway

mean5 = mean(TH1);
mean6 = mean(TH2);
mean7 = mean(TH3);
mean8 = mean(TH4);
 
value5 = max(mean5);
value6 = max(mean6);
value7 = max(mean7);
value8 = max(mean8);

result = [value5,value6,value7,value8];
end
