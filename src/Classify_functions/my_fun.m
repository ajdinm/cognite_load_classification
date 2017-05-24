function [ criterion ] = my_fun(training_set,training_labels,validation_set,validation_labels)
model = fitcsvm(training_set, training_labels,'KernelFunction', 'rbf'...
    ,'Standardize', true, 'KernelScale','auto','BoxConstraint',10);

criterion = sum(predict (model, validation_set)~=validation_labels);


end
      
      %model= fitSVMPosterior(model);
%Gaussian kernel = rbf
%Linear kernel = linear

% Predictions = predict (model, validation_set);
% [~,~,~,AUC] = perfcurve(validation_labels,probability(:,2),1);
% criterion=1-AUC;