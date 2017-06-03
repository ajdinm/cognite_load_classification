function [prediction, score]= Opt_SVM(training_set, training_labels, k, validation_set)


    CrossFoldData = cvpartition(length(training_labels),'KFold',k);
    sigma = optimizableVariable('sigma',[1e-5,1e5],'Transform','log');
    box = optimizableVariable('box',[1e-5,1e5],'Transform','log');
    minfn = @(z)kfoldLoss(fitcsvm(training_set,training_labels,'CVPartition',CrossFoldData,...
        'KernelFunction','rbf','BoxConstraint',z.box,'KernelScale',z.sigma,'Standardize',true));
    OptimisedParameters = bayesopt(minfn,[sigma,box],'IsObjectiveDeterministic',true,...
        'AcquisitionFunctionName','expected-improvement-plus', 'verbose', 0, 'Plotfcn', []);

    OptSigma=OptimisedParameters.XAtMinObjective.sigma;
    OptBox=OptimisedParameters.XAtMinObjective.box;

    %Training of classifier
    SVM_Gaussian=fitcsvm(training_set ,training_labels,'KernelFunction','rbf',...
               'BoxConstraint',OptBox,'KernelScale',OptSigma,'Standardize',true);
             [prediction, tempscore] = predict (SVM_Gaussian, validation_set);
    score=tempscore(:,2);
   
end