close all
clear
clc
%Using the features extracted with FeatureExtraction scirpt to compare
%5 different classifiers, holdout validation is employed to create a
%training and a validation set. The classifiers are evaluated according to their
%ROC curve which will be plotted to you along with the AUC result.

PortionToHoldOut=0.3; %For hold out validation must be between 0 and 1
%How many events should be included in the classification?
%Choose between HE, SW and CR or two of them or all three.
Scenario =['SW';'HE';'CR'];

CurrentFolder = mfilename('fullpath');
CurrentFolder=CurrentFolder(1:end-(length(mfilename))); %remove file name
addpath(genpath(CurrentFolder));
FeatAdd='ExtractedFeatures_';
[nrOfScenario,~]=size(Scenario);

X=[];
for n=1:nrOfScenario
    FeatureFolder=[CurrentFolder FeatAdd Scenario(n,:)];
    [flag, msg]=ErrorCheck(PortionToHoldOut, Scenario, FeatureFolder, 1, 0.5);
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

HRV = Shaibal_Features(Scenario,nrOfScenario); %Adding HRV features which already
%are normalized
X=[X,HRV(:,:)];

Y=repmat([1;0],length(X)/2,1);
Idx_CR=find(Scenario=='CR');
%if CR is among the events the labels need to be switched around for that
%event
if  Idx_CR> 0
    start=1+(Idx_CR(1,1)-1)*(length(X)/nrOfScenario);
    stop=start+(length(X)/nrOfScenario)-1;
    Y(start:stop)=repmat([0;1], (length(X)/(nrOfScenario*2)),1);
end
%Hold out validation
[Train,Test]=HoldOutValid(Y, PortionToHoldOut);

training_set=X(Train,:);
training_labels=Y(Train);
validation_set=X(Test,:);
validation_labels=Y(Test);

%Training of 5 different classifiers
SVM_Gaussian=fitcsvm(training_set ,training_labels,'KernelFunction','rbf',...
    'BoxConstraint',1000,'KernelScale','auto','Standardize',true);
SVM_Polynomial = fitcsvm(training_set, training_labels,'KernelFunction',...
    'polynomial', 'BoxConstraint',1000, 'KernelScale','auto', 'Standardize', true);
SVM_Linear  = fitcsvm(training_set, training_labels,'KernelFunction', 'linear',...
    'BoxConstraint',10000,'KernelScale','auto','Standardize', true);
Random_Forest = TreeBagger(20, training_set, training_labels, ...
    'OOBPrediction','on');
Naive_Bayes = fitcnb(training_set, training_labels);
%Validation of each classifier
[Gauss_Prediction, Gauss_Score] = predict (SVM_Gaussian, validation_set);
[Poly_Prediction, Poly_Score] = predict (SVM_Polynomial, validation_set);
[Linear_Prediction, Linear_Score] = predict (SVM_Linear, validation_set);
[Random_Forest_Prediction,Random_Forest_Score] = predict (Random_Forest, validation_set);
Random_Forest_Prediction=str2double(Random_Forest_Prediction);
[Naive_Bayes_Prediction, Naive_Bayes_Score] = predict (Naive_Bayes, validation_set);
%%
Prediction=[Gauss_Prediction, Poly_Prediction, Linear_Prediction,Random_Forest_Prediction,Naive_Bayes_Prediction];
Scores=[Gauss_Score(:,2), Poly_Score(:,2), Linear_Score(:,2), Random_Forest_Score(:,2), Naive_Bayes_Score(:,2)];
Result=EvaluateClassifiers (Prediction, Scores, validation_labels);




