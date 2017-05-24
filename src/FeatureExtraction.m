%At line 8, change the RawData directory
%At line 9, change the scenario, either 'HE', 'SW' or 'CR'

close all
clear
clc
%Raw data directory
RawData='D:\Driving\';
Scen='CR'; %Please fill in with an approite scenario, either CR, SW or HE 

CurrentFolder = mfilename('fullpath');
CurrentFolder=CurrentFolder(1:end-length(mfilename));
Time_Segments_Folder = [CurrentFolder 'Time Segments']; %For time segments folder
%SaveLocation
SaveDir=[CurrentFolder 'ExtractedFeatures_' Scen '\'];
addpath(genpath(Time_Segments_Folder));
files=dir( fullfile(Time_Segments_Folder,'*.mat'));
files = {files.name}';
totalFiles = length(files);
if totalFiles==0
    error('ERROR!! - You first need to extract the time segments using VCC_timeSegment');
end
for i=1:totalFiles
    
    load(files{i}); %One file at the time
    name=files{i};
    nametemp=strsplit(name, 'e');
    name=strcat(nametemp{1},'e');
    folder=strcat(RawData,name); %The 8GB of raw data
    switch Scen
        case 'HE'
            scenario=HE;
        case 'SW'
            scenario=SW;
        otherwise
            scenario=CR;
    end
        
    %scenario=SW; %From what scenario do you want to extract the features?

    for j=1:numel(scenario)
        scenario{j}.timeSegment(1) = scenario{j}.timeSegment(1)+10;%chop of the 10 first seconds
        scenario{j}.timeSegment(2)= scenario{j}.timeSegment(1)+50; %Extract features for next 50 seconds
    end
    RespRate = RESPIRATION(scenario,folder)';

    [HFC,nrOfZeroCross,RevRate] = STEERING_WHEEL(scenario,folder);
    HFC=HFC';
    RevRate=RevRate';
    [MeanBlinkTime,BlinksPerMin,STDAMP]=EOG(scenario,folder);
    MeanBlinkTime=MeanBlinkTime';
    BlinksPerMin=BlinksPerMin';
    STDAMP=STDAMP';

    LD=Lane_Departure(scenario,folder)';
    LPA=Lateral_position_Acceleration(scenario,folder)';
    LPFB=Lateral_position_Fixed_Body(scenario,folder)';
    LPIR=Lateral_position_in_R(scenario,folder)';
    TH1=TH(scenario,folder)';

    ToC=Time_to_Collision(scenario,folder)';
    PD=extract_pd_features(scenario,folder);
    GSR=extract_gsr_features (scenario,folder);

    MRS=GSR(:,1);%means of the raw signal
    SDRS=GSR(:,2);%standard dev of the raw signal
    MAFDRS=GSR(:,3);%the means of the absolute values of the first differences of the raw signals
    MAFDNS=GSR(:,4);%the means of the absolute values of the first differences of the normalized signals
    MASDRS=GSR(:,5);%the means of the absolute values of the second differences of the raw signals
    MASDNS=GSR(:,6);%the means of the absolute values of the second differences of the normalized signals
    AGSR=GSR(:,7);%accumulated gsr
    AVGSR=GSR(:,8);%averaged gsr
    PM=GSR(:,9);%peak_magnitude
    PD=GSR(:,10);%peak_duration
    NROP=GSR(:,11);%number_of_peaks
    TOP=GSR(:,12);%time_to_peak
    ASP=GSR(:,13);%average spectral power
    BP=GSR(:,14);%bandpower
 
 %Transform necessary features to be expressed as rate/min
    for i=1:length(scenario)
        RevRate(i)=RevRate(i)*60/(scenario{i}.timeSegment(2)-scenario{i}.timeSegment(1));
        BlinksPerMin(i)=BlinksPerMin(i)*60/(scenario{i}.timeSegment(2)-scenario{i}.timeSegment(1));
        nrOfZeroCross(i)=nrOfZeroCross(i)*60/(scenario{i}.timeSegment(2)-scenario{i}.timeSegment(1));
        RespRate(i)=RespRate(i)*60/(scenario{i}.timeSegment(2)-scenario{i}.timeSegment(1));
    end

    EventNumber={'One';'Two';'Three';'Four'};
    Features=table(RespRate, BlinksPerMin, RevRate, HFC, MeanBlinkTime,...
    nrOfZeroCross,LPA,LPFB,LPIR,TH1,ToC,PD,STDAMP,MRS,SDRS,MAFDRS,MAFDNS,...
    MASDRS,MASDNS,AGSR,AVGSR,PM,PD,NROP,TOP,ASP,BP,'RowNames',EventNumber);

    save([SaveDir name '_FEATURES.mat'], 'Features');
end
disp('Done extracting features');
