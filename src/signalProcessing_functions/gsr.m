load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive.mat')
load('/home/ajdin/workspace/AAI_project/dataset/TP02_20150518_1500_Drive_TimeSegment.mat')

y = SS_VDM_SC.Data;
t = SS_VDM_SC.TimeAxis.Data;

%y_f = conv(y, hann(2*50), 'same'); % 25 sec hanning window
%y = y_f ./ 650;

window_size = 1; % sec
[m, std1, ma1, ma21, man1, man21, acc, averaged] = get_gsr_time_features(y, t, window_size); %1 sec
% peak features might only be useful if taken from entire duration of the
% event
[peak_magnitude, peak_duration, number_of_peaks] = get_gsr_peak_features(y, t, window_size); 

[avg_powers, bandpowers] = get_gsr_freq_features(y, t, window_size);




% hold on;
% [freq, ps] = get_ps(s1, 256);
% semilogy(freq, ps, 'blue');
% [freq, ps] = get_ps(s2, 256);
% semilogy(freq, ps, 'red');
% [freq, ps] = get_ps(s3, 256);
% semilogy(freq, ps, 'blue');
% [freq, ps] = get_ps(s4, 256);
% semilogy(freq, ps, 'red');
% legend('nback', 'not back');
% hold off;
% 
% 
% [bandpower(s1) bandpower(s2) bandpower(s3) bandpower(s4)];
% [m1 m2 m3 m4];
% [man1 man2 man3 man4];
% [man21 man22 man23 man24]
% hold on;
% plot(s1, 'blue')
% plot(s2, 'red')
% plot(s3, 'blue')
% plot(s4, 'red')
% legend('nback', 'not back');
% hold off;