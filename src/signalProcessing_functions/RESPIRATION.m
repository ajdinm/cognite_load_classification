function [RespRate] = RESPIRATION(event,dir)
%Extracts the respiration rate from the respiration waveform
%RespRate stores the mean respiration rate for the particular scenario
%
%filter settings
%http://ieeexplore.ieee.org.ep.bib.mdh.se/stamp/stamp.jsp?arnumber=5447592

load (dir,'SS_VDM_RESPIRATION')
EventData=double(SS_VDM_RESPIRATION.Data);
t=SS_VDM_RESPIRATION.TimeAxis.Data;
fs=256; %sample rate

LowPassFreq=30;
HighPassFreq=0.05;

FiltData=LowPassFilter(LowPassFreq, fs, EventData, 8);
%FiltData=HighPassFilter(HighPassFreq, fs, FiltData, 4); .
FiltData=moving_avg_filter(FiltData, fs*1);

[FiltData,idx]=get_event_signals(FiltData, t, event);
RespRate=ExtractRespRate(FiltData,idx,t);

end

