close all
clear
clc
k = 5;  %Number of k-folds for feature selection algorithm and optimisation
nrOfFeat=20;
CritInclude=0.85;% Threshold will be set to 85% of maximum criterion
PortionToHoldOut=0.3; %For hold out validation must be between 0 and 1
FeatSel=true; %set to true to use feature selection (Can't use it if FeatChoice=2)
runLin=true; % run it with linear kernel as well, won't work if RunBasicSVM=true.
RunBasicSVM = false; %set to true to run the script with the basic implemented SVM as well
FeatChoice=1; %1=only physological signals, 2= only vehicle siganls, else all signals

if FeatChoice == 1 || FeatChoice==2
    combinations = 3;
else
    combinations=7;
end
CurrentFolder = mfilename('fullpath');
CurrentFolder=CurrentFolder(1:end-length(mfilename)); %remove file name
addpath(genpath(CurrentFolder));
FeatAdd='ExtractedFeatures_';
%preallocation of some cell variables
validation_labels1=cell(1,combinations);
Opt_Prediction=cell(1,combinations);
Opt_Score=cell(1,combinations);
Prediction=cell(1,combinations);
validation_labels2=cell(1,combinations);
ImpScore=cell(1,combinations);
Lin_Prediction=cell(1, combinations);
Lin_Score=cell(1,combinations);

for itr=1:combinations
    Scenario=combo(itr,combinations);
    [nrOfScenarios,~]=size(Scenario);
    X=[];

    for n=1:nrOfScenarios
        FeatureFolder=[CurrentFolder FeatAdd Scenario(n,:)];
        [flag,msg]=ErrorCheck(PortionToHoldOut, Scenario, FeatureFolder, k, CritInclude);
        if flag==1
          error(msg);
        end
        addpath(genpath(FeatureFolder));
        files=dir( fullfile(FeatureFolder,'*.mat'));
        files = {files.name}';
        totalFiles = length(files);

        for j=1:totalFiles
            load(files{j});
            if j==1 
                SF=size(Features); %size of the loops to come
            end
            for i=1:SF(2) %extracting from the table which are loaded
                temp(:,i)=Features{:,i}; %avoiding to convert all numbers to integers
            end      
            X=[X;temp];
        end
    end
    %Normalization of all features except HRV
    for i=1:size(X,2)
        X(:,i)=Normalization_Features(X(:,i));
    end
    
    HRV = Shaibal_Features(Scenario,nrOfScenarios); %Adding HRV features which already
    %are normalized
    X=[X,HRV(:,:)];  

    if FeatChoice==2 && FeatSel==true
        error('You cannot use feature selection on vehicle signals');
    end
    if runLin == true && RunBasicSVM == true
        error('You cannot run both the Linear kernel and the basic implemented one');
    end 
    if FeatChoice==1
        %Physological signals 1,2,5,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27 + HRV
        X=X(:,[1,2,5,12:55]);
    elseif FeatChoice == 2
        %Vehicle signals 3,4,6,7,8,9,10,11
        X=X(:,[3,4,6:11]);
    end

    Y=repmat([1;0],length(X)/2,1);
    Idx_CR=find(Scenario=='CR'); 
    %if CR is among the scenarios the labels need to be switched around for that
    %scenario
    if  Idx_CR> 0
        start=1+(Idx_CR(1,1)-1)*(length(X)/nrOfScenarios);
        stop=start+(length(X)/nrOfScenarios)-1;
        Y(start:stop)=repmat([0;1], (length(X)/(nrOfScenarios*2)),1);
    end

    %Hold out validation
    [Train,Test]=HoldOutValid(Y, PortionToHoldOut);

    %Sequential Feature Selection
    if FeatSel==true
    [X1, NoFeatures(itr), NoVehFeat(itr), NoPhysFeat(itr)]=Feat_Selection(X(Train,:),...
        Y(Train,:),k,nrOfFeat, CritInclude,X);
    else
        X1=X; %No feature selection
    end

    %Training and validation set for the optimised SVM
    training_set1=X1(Train,:);
    training_labels1=Y(Train);
    validation_set1=X1(Test,:);
    validation_labels1{:,itr}=Y(Test);

    [Opt_Prediction{:,itr}, Opt_Score{:,itr}]=Opt_SVM(training_set1, training_labels1, k, validation_set1);
    if runLin==true
    [Lin_Prediction{:,itr}, Lin_Score{:,itr}]=OptLin_SVM(training_set1, training_labels1, k, validation_set1);
    end
    %Basic Implemented SVM
    if RunBasicSVM == true
        sigma=0.25;
        Xnew = gaussian_kernel(X, sigma);
        training_set2=Xnew(Train,:);
        training_labels2=Y(Train);
        validation_set2=Xnew(Test,:);
        validation_labels2{:,itr}=Y(Test);
        [w,b]=quad_fitcsvm(training_set2, training_labels2);

        for i = 1:size(validation_labels2{:,itr},1)
            [Prediction{:,itr}(i,:), ImpScore{:,itr}(i,:)]= quad_predict(w, b, validation_set2(i,:));
        end
        
    end
end

%Evaluate the results from the classification

if RunBasicSVM==true
    ImplResult=EvaluateClassification(Prediction, ImpScore, validation_labels2, 3,combinations);
elseif runLin==true
     LinResult=EvaluateClassification ( Lin_Prediction, Lin_Score, validation_labels1, 2, combinations);
end
OptimisedResult=EvaluateClassification ( Opt_Prediction, Opt_Score, validation_labels1, 1, combinations);


disp('done');
