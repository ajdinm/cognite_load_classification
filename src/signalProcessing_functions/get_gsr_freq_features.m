function [ avg_powers, bandpowers ] = get_gsr_freq_features( y, t, window_size )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% freq-domain features

window_size = window_size / (abs(t(1) - t(2)));
window_size = ceil(window_size); % get number of points

windows_no = floor(length(y) / window_size); % number of windows
y = y(1:windows_no * window_size); % cutoff excess data
avg_powers = [];
bandpowers = [];
% avg power below 1 Hz; same paper as for peaks
sampling_rate = 256;
for i = 1:size(y, 1)
    [freq, ps] = get_ps(y(:,i), sampling_rate);
    avg_powers = [avg_powers, get_mean_power(ps, freq, 1)];
    bandpowers = [bandpowers, bandpower(y(:,i))];
end

% for whole task, normalize over all tasks
% divide task into frames, calculate PS of each frame
% calculate get_mean_power for frame, divide by sum of pvg power frames

