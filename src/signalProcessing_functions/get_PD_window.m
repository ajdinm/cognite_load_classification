function [ pds ] = get_PD_window(y, t)
%get_PD_window Returns 1xN vector of average PDs.
%   window_size specified in seconds

window_size = window_size / (abs(t(1) - t(2))); 
window_size = ceil(window_size); % get number of points

windows_no = floor(length(y) / window_size); % number of windows
y = y(1:windows_no * window_size); % cutoff excess data

windowed = reshape(y, window_size, windows_no);

pds = mean(windowed);

end

