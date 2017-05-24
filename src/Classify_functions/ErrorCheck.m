function [flag, msg]=ErrorCheck (P, Scenario, FeatureFolder, k, CritInclude)
msg='';
flag=0;
%checking the portionToHoldOut parameter
if P<=0 || P>=1
    flag=1;
    msg='ERROR!! - The portion to hold out must be between 0 and 1';
end
%checking for duplets
if length(unique(diff(Scenario')))~=size(Scenario, 1)
     msg='ERROR!! - No dupes allowed in the scenarios';
    flag=1;
end
%checking for other scenarios than those existing
for i = size(Scenario,1):-1:1
    if strcmp('HE', Scenario(i,:))
        Scenario(i,:)=[];
    elseif strcmp('SW', Scenario(i,:))
        Scenario(i,:)=[];
    elseif strcmp('CR', Scenario(i,:))
        Scenario(i,:)=[];
    else
        msg='ERROR!! - The scenarios are HE, SW or CR';
        flag=1;
    end
end
addpath(genpath(FeatureFolder));
files=dir( fullfile(FeatureFolder,'*.mat'));
files = {files.name}';
if isempty(files)
    msg='ERROR!! - That folder is empty';
    flag=1;
end
%checking the CritInclude parameter
if CritInclude<=0 || CritInclude>=1
    flag=1;
    msg='ERROR!! - CritInclude must be a value between 0 and 1';
end
%checking the k parameter
if k<1
    flag=1;
    msg='ERROR!! - k must be a value larger or equal to 1';
end
end