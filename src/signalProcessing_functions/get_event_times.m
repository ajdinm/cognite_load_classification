function [ event_times ] = get_event_times( cell )
%get_event_times extract time events from cell    
    event_times = [];
    for i = 1:numel(cell)
        event_times = [event_times; cell{i}.timeSegment];
    end
end