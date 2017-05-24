function [ he1_features ] = get_gsr_features( event )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y = SS_VDM_SC.Data;
t = SS_VDM_SC.TimeAxis.Data;

[he1, he2, he3, he4] = separate_event_signals(y, t, event, 10, 256);
length(he1) * (t(2) - t(1))
he1_features = get_all_gsr_signal_features(y, t);

end

