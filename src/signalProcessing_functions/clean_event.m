function [ signal ] = clean_event( signal )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

signal(signal == 0) = [];
signal = signal';


end

