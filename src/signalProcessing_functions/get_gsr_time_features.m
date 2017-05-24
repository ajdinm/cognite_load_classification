function [ means, stdevs, mean_abs, mean_abs2, mean_norm_abs, mean_norm_abs2, accumulated, averaged  ] = get_gsr_time_features( y, t, window_size )
%get_gsr_time_features Extracts TD features from GSR signal according to paper:
%   K. Mera and T. Ichimura, “Emotion analyzing method using physiological state”


window_size = window_size / (abs(t(1) - t(2))); 
window_size = ceil(window_size); % get number of points

windows_no = floor(length(y) / window_size); % number of windows
y = y(1:windows_no * window_size); % cutoff excess data

y_norm = (y - mean(y)) ./ std(y);

y = reshape(y, window_size, windows_no);
y_norm = reshape(y, window_size, windows_no);

% each col in y is one window

means = mean(y); % feature 1, mean of signals (col for each window)
stdevs = std(y); % feature 2, stdev of signals 


mean_abs = mean(abs(diff(y))); % feature 3, means of abs of
                                  %first differences sum(X_{n+1} - X_{n})
                                  
mean_norm_abs = mean(abs(diff(y_norm)))'; % feature 4, means of abs of
                %           first differences sum(Xnorm_{n+1} - Xnorm_{n})

y = y';
x_n = y;
x_n(:,1) = [];
x_n(:, 1) = [];
x_np2 = y;
x_np2(:, end) = [];
x_np2(:, end) = [];

mean_abs2 = mean(abs(x_np2 - x_n)); % feature 5, means of abs of
                                  %first differences sum(X_{n+2} - X_{n})

y_norm = y_norm';                           
x_n = y_norm;
x_n(:, 1) = [];
x_n(:, 1) = [];
x_norm_p2 = y_norm;
x_norm_p2(:, end) = [];
x_norm_p2(:, end) = [];

mean_norm_abs2 = mean(abs(x_norm_p2 - x_n)); % feature 6

accumulated = sum(y_norm); % accumulated normalized gsr

total_time = t(end) - t(1);
averaged = accumulated ./ total_time;


end

