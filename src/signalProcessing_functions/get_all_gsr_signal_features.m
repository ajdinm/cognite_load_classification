function [ features ] = get_all_gsr_signal_features( y, t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

window_size = ((t(2)-t(1))*length(y)); % entire signal
[m, std1, ma1, ma21, man1, man21, acc, averaged] = get_gsr_time_features(y, t, window_size); %1 sec
% peak features might only be useful if taken from entire duration of the
% event
[peak_magnitude, peak_duration, number_of_peaks, time_to_peak] = get_gsr_peak_features(y, t, window_size); 

[avg_powers, bandpowers] = get_gsr_freq_features(y, t, window_size);
features = [m, std1, ma1, ma21, man1, man21, acc, averaged, ...
           peak_magnitude, peak_duration, number_of_peaks, time_to_peak, ...
           avg_powers, bandpowers];
       %size(features)
        
end

