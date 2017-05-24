function [result] = extract_gsr_features( event,dir)
load(dir,'SS_VDM_SC');
%load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive_TimeSegment.mat')

y = double(SS_VDM_SC.Data);

t = SS_VDM_SC.TimeAxis.Data;

result = get_all_gsr_features(y, t, [event]);
%cr_features = get_all_gsr_features(y, t, [CR]);
%sw_features = get_all_gsr_features(y, t, [SW]);

%cognitively_loaded = [he_features(1, :); he_features(3,:); ...
                      %cr_features(1,:); cr_features(3,:)];
%not_cognitively_loaded = [he_features(2, :); he_features(4,:); ...
                      %cr_features(2,:); cr_features(4,:)];
                  
end