function [ magnitudes, durations, number_of_peaks, time_to_peak ] = get_gsr_peak_features( y, t, window_size )
%get_peak_features Returns features of the peaks in signal (windowed)
%   J. Zhou et al. “Dynamic Workload Adjustments in Human-Machine Systems Based on GSR Features,�?

window_size = window_size / (abs(t(1) - t(2)));
window_size = ceil(window_size); % get number of points

windows_no = floor(length(y) / window_size); % number of windows
y = y(1:windows_no * window_size); % cutoff excess data

time_step = abs(t(1) - t(2));
magnitudes = [];
durations = [];
number_of_peaks = [];
time_to_peak = [];
for i = 1:size(y, 1) %for each window
    [pks, locs, width, promience] = findpeaks(y(i, :),  'MinPeakDistance', 265*10); % 10 sec between peaks
    magnitudes = [magnitudes, sum(pks)]; % feature 7
    durations = [durations, sum(width * time_step)];  % feature 8
    number_of_peaks = [number_of_peaks, length(pks)]; % feature 9
    time_to_peak = [time_to_peak, locs*time_step]; % time needed for first peak to occur
end


time_to_peak = min(min(time_to_peak));
end

