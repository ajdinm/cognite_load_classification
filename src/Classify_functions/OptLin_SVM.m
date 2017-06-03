function [prediction, score]= OptLin_SVM(training_set, training_labels, k, validation_set)

    CrossFoldData = cvpartition(length(training_labels),'KFold',k);
    sigma = optimizableVariable('sigma',[1e-5,1e5],'Transform','log');
    box = optimizableVariable('box',[1e-5,1e5],'Transform','log');
    minfn = @(z)kfoldLoss(fitcsvm(training_set,training_labels,'CVPartition',CrossFoldData,...
        'KernelFunction','linear','BoxConstraint',z.box,'KernelScale',z.sigma,'Standardize',true));
    OptimisedParameters = bayesopt(minfn,[sigma,box],'IsObjectiveDeterministic',true,...
        'AcquisitionFunctionName','expected-improvement-plus', 'verbose', 0, 'Plotfcn', []);

    OptSigma=OptimisedParameters.XAtMinObjective.sigma;
    OptBox=OptimisedParameters.XAtMinObjective.box;

    %Training of classifier
    SVM_Linear=fitcsvm(training_set ,training_labels,'KernelFunction','linear',...
               'BoxConstraint',OptBox,'KernelScale',OptSigma,'Standardize',true);
             [prediction, tempscore] = predict (SVM_Linear, validation_set);
    score=tempscore(:,2);
   
end