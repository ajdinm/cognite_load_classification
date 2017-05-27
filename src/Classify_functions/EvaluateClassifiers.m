function [  ClassifyResult ] = EvaluateClassifiers(Prediction,Score, validation_labels)
X_score=cell(1:5);
Y_score=cell(1:5);
for j = 1:size(Prediction,2)
    [X_score{1,j},Y_score{1,j},~,AUC_score(j)] = perfcurve(validation_labels,Score(:,j),1);
    AUC_score(j)=round(AUC_score(j),2);
    %plotting ROC for the two cognitnive loaded and the not loaded events
    
    TP(j)=0;
    FP(j)=0;
    TN(j)=0;
    FN(j)=0;
    for i=1:length(validation_labels)
        if Prediction(i,j) == 1
            if Prediction(i,j) == validation_labels(i)
                TP(j) = TP(j) +1;  %true positive
            else
                FP(j) = FP(j) +1;  %false positive
            end
        else
            if Prediction(i,j) == validation_labels(i)
                TN(j) = TN(j)+1; %true negative
            else
                FN(j) = FN(j)+1; %false negative
            end
        end
    end
    
    Accuracy(j)=TP(j)+TN(j)/length(validation_labels);
    TPR(j)=TP(j)/(TP(j)+FN(j)); %True positive rate aka Sensitivity
    FPR(j)=FP(j)/(TN(j)+FP(j)); %False positive rate
end

ClassifyResult=table(AUC_score, TP, FP, TN, FN, TPR, FPR, Accuracy);
AUC=num2str(AUC_score');
set(gcf, 'color', 'w');
figure(1)
plot(X_score{1,1}, Y_score{1,1}, X_score{1,2}, Y_score{1,2}, X_score{1,3},...
    Y_score{1,3}, X_score{1,4}, Y_score{1,4}, X_score{1,5}, Y_score{1,5});
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('Receiver Operating Characteristic curve for different classifiers');
legend(['SVM Gaussian Kernel, AUC=' AUC(3,:)], ['SVM Polynomial Kernel, AUC=', AUC(2,:)], ...
    ['SVM Linear Kernel, AUC=',AUC(1,:)], ['Random Forest, AUC=',AUC(4,:)],...
    ['Naive Bayes, AUC=', AUC(5,:)]);

end

