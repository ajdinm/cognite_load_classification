function [ freq, p_w ] = get_ps( signal, fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(signal);
freq = [0:N-1];
freq= freq*fs/N;
p_w = abs(fft(signal));
n_half = ceil(N/2);
freq = freq(1:n_half);
p_w = p_w(1:n_half);
end

