function [ result ] = Time_to_Collision(event,dir)

% TTC - Time to colision, distance to lead vehicule divided by the differnece in speed between the 2.
%Speed of the vehicule - velX
%Speed of event vehicule - eventVehVelX
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
[Data2,idx]=get_event_signals(Data2, t, event);
[Data3,idx]=get_event_signals(Data3, t, event);

WinSize=100;


t1=t(idx(1,1):idx(1,2));              t2=t(idx(2,1):idx(2,2));              t3=t(idx(3,1):idx(3,2));              t4=t(idx(4,1):idx(4,2));

Data11 = Data1(idx(1,1):idx(1,2));    Data12 = Data1(idx(2,1):idx(2,2));    Data13 = Data1(idx(3,1):idx(3,2));    Data14 = Data1(idx(4,1):idx(4,2));

Data21 = Data2(idx(1,1):idx(1,2));    Data22 = Data2(idx(2,1):idx(2,2));    Data23 = Data2(idx(3,1):idx(3,2));    Data24 = Data2(idx(4,1):idx(4,2));

Data31 = Data3(idx(1,1):idx(1,2));    Data32 = Data3(idx(2,1):idx(2,2));    Data33 = Data3(idx(3,1):idx(3,2));    Data34 = Data3(idx(4,1):idx(4,2));

% TTC - distance to lead /(lead vehicule speed - own vehicule speed)

TTC1 = Data31/(Data21-Data11);
TTC2 = Data32/(Data22-Data12);
TTC3 = Data33/(Data23-Data13);
TTC4 = Data34/(Data24-Data14);


% Features
% Average Time to Collision

mean1 = mean(TTC1);
mean2 = mean(TTC2);
mean3 = mean(TTC3);
mean4 = mean(TTC4);

value1 = min(mean1);
value2 = min(mean2);
value3 = min(mean3);
value4 = min(mean4);

result = [value1,value2,value3,value4];
end
