function [ features ] = get_all_gsr_features( y, t, event )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fs = 1 / (t(2) - t(1));
[s1, s2, s3, s4] = separate_event_signals(y, t, event, 10, fs);
features = get_all_gsr_signal_features(s1, t);
% size(features)
features = [features;get_all_gsr_signal_features(s2, t)];
features = [features;get_all_gsr_signal_features(s3, t)];
features = [features;get_all_gsr_signal_features(s4, t)];

end

