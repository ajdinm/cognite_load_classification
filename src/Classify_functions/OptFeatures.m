function [ criterion ] = OptFeatures(training_set,training_labels,validation_set,validation_labels)

model = fitcsvm(training_set, training_labels,'KernelFunction', 'rbf'...
    ,'Standardize', true, 'KernelScale','auto','BoxConstraint',100);

criterion = sum(predict (model, validation_set)~=validation_labels);


% 
% [w, b]=quad_fitcsvm(training_set, training_labels);
% for i=1:size(validation_labels,1)
%     Prediction(i,1)= quad_predict(w, b, validation_set(i,:));
% end
% criterion=sum(Prediction~=validation_labels);
end