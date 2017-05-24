function [ avg_power ] = get_mean_power( ps, freq, thr )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

indices = find(freq <= thr); % take power below 1 Hz
avg_power = mean(ps(indices));

end

