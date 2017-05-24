function [ y ] = remove_blinks( y, t )
%remove_blinks Removes blinks from pupil diameter readings
%   Detailed explanation goes here

y_temp = y;
y_temp(y_temp == 0) = [];
mu = mean(y_temp);
sigma = std(y_temp);

low_threshold = mu - 3 * sigma;
high_threshold = mu + 3 * sigma;
artifact_value = 0.01;

y(y ~= 0 & (y < low_threshold | y > high_threshold)) = artifact_value;

% if o_i == 0 AND o_{i-1} == artifact THEN o_{i-1} == 0
zero_idx = find(y == 0);
preceding_idx = zero_idx - 1; 
preceding_idx(preceding_idx < 1) = []; %remove invalid values
y(y(preceding_idx) == artifact_value) = 0;

% if o_i == 0 AND o_{i+1} == artifact THEN o_{i+1} == 0
zero_idx = find(y == 0);
following_idx = zero_idx + 1; 
following_idx(following_idx > length(y)) = []; %remove invalid values
y(y(following_idx) == artifact_value) = 0;
y(y == artifact_value) = 0;
% pupil position if needed

blink_offset = 3; % blink starts 60 ms before first zero reading
                  % blink ends with last 0 reading
                  
blinks = []; % indicies where blinks start and end
max = length(y);
i = 1;
while 1 == 1
    if i > max
        break
    end
    % skip non zero elements
    while i <= max && y(i) ~= 0
        i = i + 1;
    end
    %now at first zero el
    b_s = i - blink_offset;
    if b_s < 1 
        b_s = 1;
    end
    % skip zeroes
    while i <= max && y(i) == 0
        i = i + 1;
    end
    % now at first non zero el
    b_e = i;      
    if b_e > max
        b_e = max;
    end
    blinks = [blinks;b_s, b_e];    
end
rows = size(blinks);
rows = rows(1);
for i = 1:rows
    start_i = blinks(i, 1);
    end_i = blinks(i, 2);
    x0 = t(start_i);
    x1 = t(end_i);
    y0 = y(start_i);
    y1 = y(end_i);
    % y = mx + c
    m =  (y0 - y1) / (x0 - x1);
    c = y0 - ((x0 * (y0 - y1)) / (x0 - x1));
    
    index_range = start_i:end_i;
    y(index_range) = t(index_range) .* m;
    y(index_range) = y(index_range) + c;
end

y =  moving_avg_filter(y, 50);

%remove inital jump
y(1:50) = 0.005065;

end

