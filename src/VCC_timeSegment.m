clear all
clc
% %Extract_VCC_timeSegment
% 
% %     eventHiddenExitState (?HEx? in the XL-file) %Hidden exit state
% %     eventCarFromRightState (?CRx? in the XL-file) %Car from right state
% %     sideWindActive %Side wind scenario state
% %     eventFICAState %FICA state
% %     nBackActive %nback task on/off
% %     nBackNumber %nback task on/off
% 
dir_raw_data = 'D:\Driving'; %Directory of the raw data
CurrentFolder = mfilename('fullpath');
TimeSegmentsFolder=[CurrentFolder(1:end-length(mfilename)) 'Time Segments\'];
addpath(genpath(dir_raw_data));
% 
 %configData = importdata('vccConfig.mat');
% 
files=dir( fullfile(dir_raw_data,'*.mat'));
files = {files.name}';

totalFiles = length(files);

for k = 1:totalFiles
    disp (['    ' files{k}]);
    [~,name,ext] = fileparts(files{k});
       
    data = importdata(files{k});
   
    % Hidden exit 
    HE_clstart_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==1).' 0])]~=0)';
    HE_clend_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==10).' 0])]~=0)';
    HE_clsv_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==2).' 0])]~=0)';
    HE_clsp_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==3).' 0])]~=0)';
    HE_clev_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==4).' 0])]~=0)';
    HE_clep_Idx = find([0 diff([(data.SS_VDM_eventHiddenExitState.Data==5).' 0])]~=0)';
   
    HE = cell(4,1);
    
    j=0;
    for i = 1:4
        HE{i}.clstart_Time = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clstart_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clstart_Idx(i+j+1)-1)];
        HE{i}.clend_Time   = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clend_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clend_Idx(i+j+1)-1)];
        HE{i}.clsv_Time    = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clsv_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clsv_Idx(i+j+1)-1)];
        HE{i}.clsp_Time    = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clsp_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clsp_Idx(i+j+1)-1)];
        HE{i}.clev_Time    = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clev_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clev_Idx(i+j+1)-1)];
        HE{i}.clep_Time    = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clep_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clep_Idx(i+j+1)-1)];
        HE{i}.timeSegment  = [data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clstart_Idx(i+j)) data.SS_VDM_eventHiddenExitState.TimeAxis.Data(HE_clend_Idx(i+j+1)-1)];
        
        if( mod(i,2)==1)
            HE{i}.nBackTask = 1;
        else
            HE{i}.nBackTask = 0;
        end
        
        j=j+1;
    end
   
    clear HE_clstart_Idx HE_clend_Idx HE_clsv_Idx HE_clsp_Idx ...
            HE_clev_Idx HE_clep_Idx;
   
    % Car from right
    CR_clstart_Idx = find([0 diff([(data.SS_VDM_eventCarFromRightState.Data==1).' 0])]~=0)';
    CR_clend_Idx = find([0 diff([(data.SS_VDM_eventCarFromRightState.Data==10).' 0])]~=0)';
    CR_clcv_Idx = find([0 diff([(data.SS_VDM_eventCarFromRightState.Data==2).' 0])]~=0)';
    CR_clxp_Idx = find([0 diff([(data.SS_VDM_eventCarFromRightState.Data==4).' 0])]~=0)';
    CR_cltm_Idx = find([0 diff([(data.SS_VDM_eventCarFromRightState.Data==3).' 0])]~=0)';
    
    CR = cell(4,1);
    
    j=0;
    for i = 1:4
        CR{i}.clstart_Time = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clstart_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clstart_Idx(i+j+1)-1)];
        CR{i}.clend_Time   = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clend_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clend_Idx(i+j+1)-1)];
        CR{i}.clcv_Time    = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clcv_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clcv_Idx(i+j+1)-1)];
        CR{i}.clxp_Time    = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clxp_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clxp_Idx(i+j+1)-1)];        
        CR{i}.cltm_Time    = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_cltm_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_cltm_Idx(i+j+1)-1)];
        CR{i}.timeSegment  = [data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clstart_Idx(i+j)) data.SS_VDM_eventCarFromRightState.TimeAxis.Data(CR_clend_Idx(i+j+1)-1)];
        
        if( mod(i,2)==1)
            CR{i}.nBackTask = 1;
        else
            CR{i}.nBackTask = 0;
        end
        
        j=j+1;
    end
    
    clear CR_clstart_Idx CR_clend_Idx CR_clcv_Idx CR_clxp_Idx CR_cltm_Idx;
    
    % Side wind    
    SW_clstart_Idx = find([0 diff([(data.SS_VDM_sideWindActive.Data==1).' 0])]~=0);
    SW = cell(4,1);
    
    j=0;
    for i = 1:4
        SW{i}.timeSegment  = [data.SS_VDM_sideWindActive.TimeAxis.Data(SW_clstart_Idx(i+j)) data.SS_VDM_sideWindActive.TimeAxis.Data(SW_clstart_Idx(i+j+1)-1)];
        
        if( mod(i,2)==1)
            SW{i}.nBackTask = 1;
        else
            SW{i}.nBackTask = 0;
        end
        
        j=j+1;
    end

    clear SW_clstart_Idx;
    
    % FICA    
    BC_clstart_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==2).' 0])]~=0)';
    BC_clend_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==50).' 0])]~=0)';
    BC_2_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==3).' 0])]~=0)';
    BC_3_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==4).' 0])]~=0)';
    BC_4_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==5).' 0])]~=0)';
    BC_5_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==6).' 0])]~=0)';
    BC_6_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==7).' 0])]~=0)';
    %BC_5_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==7).' 0])]~=0)'; % only for TP13
    %BC_6_Idx = find([0 diff([(data.SS_VDM_eventFICAState.Data==8).' 0])]~=0)'; % only for TP13       
       
    BC.clstart_Time = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clstart_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clstart_Idx(2)-1)];
    BC.clend_Time   = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clend_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clend_Idx(2)-1)];
    BC.BC2_Time    = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_2_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_2_Idx(2)-1)];
    BC.BC3_Time    = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_3_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_3_Idx(2)-1)];        
    BC.BC4_Time    = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_4_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_4_Idx(2)-1)];
    BC.BC5_Time    = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_5_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_5_Idx(2)-1)];
    BC.BC6_Time    = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_6_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_6_Idx(2)-1)];
    BC.timeSegment  = [data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clstart_Idx(1)) data.SS_VDM_eventFICAState.TimeAxis.Data(BC_clend_Idx(2)-1)];
    
    clear BC_clstart_Idx BC_clend_Idx BC_2_Idx BC_3_Idx BC_4_Idx ...
            BC_5_Idx BC_6_Idx;
    
    % nBack task
    NB_clstart_Idx = find([0 diff([(data.SS_VDM_nBackActive.Data==1).' 0])]~=0);
    numCell=numel(NB_clstart_Idx)/2;
    NB = cell(numCell,1);
    
    j=0;
    for i = 1:numCell
        NB{i}.timeSegment  = [data.SS_VDM_nBackActive.TimeAxis.Data(NB_clstart_Idx(i+j)) data.SS_VDM_nBackActive.TimeAxis.Data(NB_clstart_Idx(i+j+1)-1)];
        
        switch i
            case {1, 4}
                NB{i}.task='HE';
            case {2, 5}
                NB{i}.task='SW';
            case {3, 6}
                NB{i}.task='CR';
            otherwise
                NB{i}.task='NaN';
        end
        
        j=j+1;
    end
    
    clear NB_clstart_Idx numCell;
    save([TimeSegmentsFolder name '_TimeSegment.mat'], 'HE','CR','BC','SW','NB');
end

