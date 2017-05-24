function [HFC,nrOfZeroCross,RevRate ] = STEERING_WHEEL(event,dir)
%Function to extract features from the steering wheel signal
%Three features are extracted and return from the function:
%Number of zero crossings
%Reversal rate
%High Frequency Component of the steering wheel angle variation

    load (dir,'SS_VDM_stwAngle')
    fs=50; %sample rate
    low=0.6;
    high=0.3;
    t=SS_VDM_stwAngle.TimeAxis.Data;
    Data=rad2deg(SS_VDM_stwAngle.Data);

    FiltData=LowPassFilter(low,fs,Data,2); %Filtering the signal
    FiltDataHigh=HighPassFilter(high,fs,FiltData,2); %Only used to calculate HFC
    [FiltData,idx]=get_event_signals(FiltData, t, event);

    %Extracting High frequency component of steering wheel angle 
    for i=1:length(event)
        Pall=rms(FiltData(idx(i,1):idx(i,2))); %root mean square
        Pband=rms(FiltDataHigh(idx(i,1):idx(i,2)));
        HFC(i) = Pband/Pall;
    end

    %Extracting nr of zero crossings, numFeatuers corresponds to the number of
    %featuers per scenario
    for i=1:length(event)
        nrOfZeroCross(i,:)=ZeroCross(idx(i,1), idx(i,2), Data);
    end

    %Extracting reversal rate 
    for i=1:1:length(event)
        RevRate(i)=Rev_Rate(FiltData, idx(i,:), t);
    end 
end

%Papers and references
%http://www.ao.i2.psychologie.uni-wuerzburg.de/fileadmin/06020230/user_upload/11-_KrajewskiSommerSTEERING_WHEEL_BEHAVIOR_BASED_ESTIMATION_OF_FATIGUE.pdf
%http://www.its.leeds.ac.uk/projects/haste/Haste%20D2%20v1-3%20small.pdf
%https://www-nrd.nhtsa.dot.gov/pdf/esv/esv20/07-0262-o.pdf 
%https://www-nrd.nhtsa.dot.gov/pdf/esv/esv20/07-0262-O.pdf

