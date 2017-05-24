function [ result ] = Lane_Departure(event,dir)


% Lane Flag departure is calculated and after a algorithm it can either be flaged = 1 or considered
% t short to react to it = 0. Simple count can show how much it occurs in each scenario

load (dir,'SS_VDM_laneDeparture');     %---------------- data directory to be changed

fs=50;
low=1;
high=0.1;
t=SS_VDM_laneDeparture.TimeAxis.Data;
Data=SS_VDM_laneDeparture.Data;

[Data,idx]=get_event_signals(Data, t, event);

WinSize=100;


t1=t(idx(1,1):idx(1,2));            t2=t(idx(2,1):idx(2,2));            t3=t(idx(3,1):idx(3,2));            t4=t(idx(4,1):idx(4,2));

Data1 = Data(idx(1,1):idx(1,2));
Data2 = Data(idx(2,1):idx(2,2));
Data3 = Data(idx(3,1):idx(3,2));
Data4 = Data(idx(4,1):idx(4,2));

LENGHT1=(max(size((Data1))));
LENGHT2=(max(size((Data2))));
LENGHT3=(max(size((Data3))));
LENGHT4=(max(size((Data4))));

count1 =0;
for i=1:LENGHT1
 if Data1(i)==1
     count1=count1+1;
 end
end
   
count2 =0;
for i=1:LENGHT2
 if Data2(i)==1
     count2=count2+1;
 end
end
   
count3 =0;
for i=1:LENGHT3
 if Data4(i)==1
     count3=count3+1;
 end
end

count4 =0;
for i=1:LENGHT4
 if Data4(i)==1
     count4=count4+1;
 end
end
 
result=[count1,count2,count3,count4];
    
end
