function [ filtered_signal ] = moving_avg_filter(signal, step)
%Performs moving average filter on the signal

coeff = ones(1, step) / step;
filtered_signal = filter(coeff, 1, signal);

end

