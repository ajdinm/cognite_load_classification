function [ s1, s2, s3, s4 ] = separate_event_signals(y, t, events, ignore, fs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% ignore == how many seconds to ignore at start

%y = get_event_signal(y, t, events);
%y = y';

[r, c] = size(y);
if r > 1
    y = y';
end

points = get_event_times(events);
points_size = size(points);
threshold = 0.001;
nonzero_idx = [];
event_duration = points(1, 2) - points(1, 1);
zero_len = 0;
for i = 1:points_size(1)
    segment = [points(i, 1) points(i,1) + event_duration];
    t_temp = t - segment(1) < threshold;
    
    begin_idx = find(t_temp);
    begin_idx = begin_idx(end);       
    end_idx = find(t - segment(2) < threshold);
    end_idx = end_idx(end);
    if length(nonzero_idx) == 0
        nonzero_idx = [nonzero_idx; begin_idx : end_idx];        
        zero_len = end_idx - begin_idx;
    else
        nonzero_idx = [nonzero_idx; begin_idx : begin_idx + zero_len];
    end
end
nonzero_idx_size = size(nonzero_idx);
signals = [];
for i = 1:nonzero_idx_size(1)    
    tempzero_idx = setdiff(1:length(y), nonzero_idx(i,:));
    yi = y;
    yi(tempzero_idx) = 0;
    signals = [signals;yi];
end
signal_len = size(signals(1,:));
signal_len = signal_len(2);
new_sig = [];
s = size(signals);
for i = 1:s(1)
    new_sig = [new_sig;clean_event(signals(i,:)')];
end
signals = new_sig;
avgs = sum(signals') ./ signal_len;
% %ignore first 10
% ignore_len = fs * ignore;
% signals(:, 1:ignore_len) = [];
% % take only first 50sec
% len = fs * 50;
%signals(:, len:end) = [];
s1 = signals(1,:);
s2 = signals(2,:);
s3 = signals(3,:);
s4 = signals(4,:);

end