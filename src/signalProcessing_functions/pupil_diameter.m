load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive.mat');
load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive_TimeSegment.mat')

t = SS_VDM_sePupilDiameter.TimeAxis.Data;
y = SS_VDM_sePupilDiameter.Data';

y = remove_blinks(y, t);

window_size = 1;

% feature of pupil diameter signal; average PD
window_diameteres = get_PD_window(y, t, window_size); 
