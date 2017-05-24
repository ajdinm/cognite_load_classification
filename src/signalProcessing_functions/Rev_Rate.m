function [ ReversalRate ] = Rev_Rate( FiltData, idx,t )

temp=FiltData +15;
temp2=FiltData -15;

[~,maxpeaks]=findpeaks(temp(idx(1,1):idx(1,2)), 'MinPeakHeight',0.3 ); %maxpeaks
[~,minpeaks]=findpeaks(-temp2(idx(1,1):idx(1,2)),'MinPeakHeight',0.3); %minpeaks

len=length(maxpeaks)+length(minpeaks);
peaks=zeros(1,len);
if length(maxpeaks) > length(minpeaks)  %start with a max peak
    peaks(1:2:end)=maxpeaks; % Odd-Indexed Elements
    peaks(2:2:end)=minpeaks; % Even-Indexed Elements
else %start with a min peak
    peaks(1:2:end)=minpeaks; % Odd-Indexed Elements
    peaks(2:2:end)=maxpeaks; %Even-Indexed Elements
end

threshold=2;
for i = 1:1:len-1
    if (abs(FiltData(idx(1,1)+peaks(1,i))-FiltData(idx(1,1)+peaks(1,i+1)))) > threshold
        
    else
        peaks(1,i)=0;
    end
end
ReversalRate = peaks(peaks~=0);
ReversalRate=length (ReversalRate);

end

