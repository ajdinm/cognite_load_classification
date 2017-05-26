function [  ClassifyResult ] = EvaluateClassification(Prediction,Score, validation_labels, figNr)
    for j = 1:7
        Score{:,j}=double(Score{:,j});
        [X_score,Y_score,~,AUC_score(j,:)] = perfcurve(validation_labels{:,j},Score{:,j},1);


        %plotting ROC for the two cognitnive loaded and the not loaded events
        switch(figNr)
            case 1
                titleName='Support Vector Machine with Gaussian kernel';
            otherwise 
                titleName='Implemented Support Vector Machine with Gaussian Kernel';
        end
        hold on
        set(gcf, 'color', 'w');
        figure(figNr)
        plot(X_score, Y_score);

        TP(j,:)=0;
        FP(j,:)=0;
        TN(j,:)=0;
        FN(j,:)=0;
            for i=1:length(validation_labels{:,j})
                if Prediction{:,j}(i,:) == 1
                    if Prediction{:,j}(i,:) == validation_labels{:,j}(i,:)
                        TP(j,:) = TP(j,:) +1;  %true positive
                    else
                        FP(j,:) = FP(j,:) +1;  %false positive
                    end
                else
                    if Prediction{:,j}(i,:) == validation_labels{:,j}(i,:)
                        TN(j,:) = TN(j,:)+1; %true negative
                    else
                        FN(j,:) = FN(j,:)+1; %false negative
                    end
                end
            end

            TPR(j,:)=TP(j,:)/(TP(j,:)+FN(j,:)); %True positive rate aka Sensitivity
            FPR(j,:)=FP(j,:)/(TN(j,:)+FP(j,:)); %False positive rate

     end
    AUC_score=round(AUC_score,2);
    TPR=round(TPR,2);
    FPR=round(FPR,2);
    ClassifyResult=table(AUC_score, TPR, FPR, TP, FP, TN, FN);
    AUC_score=num2str(AUC_score);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    legend(['All           AUC=' AUC_score(1,:)], ['SW, CR  AUC=' AUC_score(2,:)]...
        ,[ 'SW, HE  AUC=' AUC_score(3,:)], ['CR, HE   AUC=' AUC_score(4,:)]...
        ,['CR          AUC=' AUC_score(5,:)], ['HE          AUC=' AUC_score(6,:)]...
        ,['SW         AUC=' AUC_score(7,:)]); 
    str={'Receiver Operating Characteristic curve for', titleName};
    title(str);
    hold off
end
