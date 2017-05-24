function [ out_signal, idx ] = get_event_signals( signal, t, cells )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    cells_size = size(cells);
    points = [];
    for i = 1:cells_size(2)
        points = [points;get_event_times(cells(:,i))];
    end
    point_size = size(points);
    threshold = 0.001;
    nonzero_idx = [];
    for i = 1:point_size(1)
        segment = points(i,:);
        t_temp = t - segment(1) < threshold;
        begin_idx = find(t_temp);
        begin_idx = begin_idx(end);%
        
        end_idx = find(t - segment(2) < threshold);
        end_idx = end_idx(end);%
        idx(i,1)=begin_idx;
        idx(i,2)=end_idx;
        nonzero_idx = [nonzero_idx, begin_idx : end_idx];      
    end 
    zero_idx = setdiff(1:length(signal), nonzero_idx);
    out_signal = signal;
    out_signal(zero_idx) = 0;  
end