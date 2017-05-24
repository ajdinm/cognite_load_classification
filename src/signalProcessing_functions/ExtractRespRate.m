function RespRate = ExtractRespRate(FiltData,idx,timeaxis)
%Extracting the respiration rate from the filtered data.
    for i=1:4
        Peaks=findpeaks(FiltData(idx(i,1):idx(i,2)), timeaxis(idx(i,1):idx(i,2)),'MinPeakHeight',200,'MinPeakDistance',1.5);
        RespRate(i)=length(Peaks);
    end
end
