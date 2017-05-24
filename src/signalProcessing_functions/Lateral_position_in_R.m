function [ result ] = Lateral_position_in_R(event,dir)

load (dir,'SS_VDM_latPos') %---------------- data directory to be changed

fs=50;
low=1;
high=0.1;
t=SS_VDM_latPos.TimeAxis.Data;
Data=SS_VDM_latPos.Data;

[Data,idx]=get_event_signals(Data, t, event);

WinSize=100;

t1=t(idx(1,1):idx(1,2));
t2=t(idx(2,1):idx(2,2));
t3=t(idx(3,1):idx(3,2));
t4=t(idx(4,1):idx(4,2));

Data1 = Data(idx(1,1):idx(1,2));
Data2 = Data(idx(2,1):idx(2,2));
Data3 = Data(idx(3,1):idx(3,2));
Data4 = Data(idx(4,1):idx(4,2));

[pks1,locs1] = findpeaks(Data1);
[pks2,locs2] = findpeaks(Data2);
[pks3,locs3] = findpeaks(Data3);
[pks4,locs4] = findpeaks(Data4);

cycles1 = diff(locs1);
cycles2 = diff(locs2);
cycles3 = diff(locs3);
cycles4 = diff(locs4);

% Mean values
meanCycle1 = mean(cycles1);
meanCycle2 = mean(cycles2);
meanCycle3 = mean(cycles3);
meanCycle4 = mean(cycles4);


result = [meanCycle1,meanCycle2,meanCycle3,meanCycle4];
end

