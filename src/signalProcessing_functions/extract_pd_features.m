function [result] = extract_pd_features(event,dir)
load(dir,'SS_VDM_sePupilDiameter');
%load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive_TimeSegment.mat')

t = SS_VDM_sePupilDiameter.TimeAxis.Data;
y = SS_VDM_sePupilDiameter.Data';

y = remove_blinks(y, t);

[he1, he2, he3, he4] = separate_event_signals(y, t, [event], 10, 50);
result = [mean(he1);mean(he2);mean(he3);mean(he4)];

% [cr1, cr2, cr3, cr4] = separate_event_signals(y, t, [CR], 10, 50);
% cr_features = [mean(cr1);mean(cr2);mean(cr3);mean(cr4)];
% 
% [sw1, sw2, sw3, sw4] = separate_event_signals(y, t, [SW], 10, 50);
% sw_features = [mean(sw1);mean(sw2);mean(sw3);mean(sw4)];

end