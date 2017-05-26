function [  ClassifyResult ] = EvaluateClassification(Prediction,Score, validation_labels, figNr)

        X_score=cell(1,7);
        Y_score=cell(1,7);
    for j = 1:7
        Score{:,j}=double(Score{:,j});
        [X_score{1,j},Y_score{1,j},~,AUC_score(j,:)] = perfcurve(validation_labels{:,j},Score{:,j},1);


        %plotting ROC for the two cognitnive loaded and the not loaded events
        switch(figNr)
            case 1
                titleName='Toolbox Support Vector Machine with Gaussian kernel';
            otherwise 
                titleName='Implemented Support Vector Machine with Gaussian Kernel';
        end

         

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
            Accuracy(j,:)=(TP(j,:)+TN(j,:)) / length(validation_labels{:,j});
     end
    AUC_score=round(AUC_score,2);
    TPR=round(TPR,2);
    FPR=round(FPR,2);
    ClassifyResult=table(AUC_score, TP, FP, TN, FN, TPR, FPR, Accuracy);
    AUC_score=num2str(AUC_score);
    
    %Plotting
    hold on
    set(gcf, 'color', 'w');
   
    hFig=figure(figNr);
    set(hFig, 'Position', [100 100 1250 500]);
    
    sub1 = subplot(1,2,1); %The combinations goes into this plot
    
    plot(X_score{1,1}, Y_score{1,1},X_score{1,2}, Y_score{1,2},X_score{1,3},...
        Y_score{1,3},X_score{1,4}, Y_score{1,4});
    xlabel(sub1,'False Positive Rate');
    ylabel(sub1,'True Positive Rate');
    legend(['All           AUC=' AUC_score(1,:)], ['SW, CR  AUC=' AUC_score(2,:)]...
        ,[ 'SW, HE  AUC=' AUC_score(3,:)],['CR, HE   AUC=' AUC_score(4,:)]);
    
    sub2 = subplot(1,2,2); %The individually scenarios goes into this
    plot(X_score{1,5}, Y_score{1,5},X_score{1,6}, Y_score{1,6},X_score{1,7},...
        Y_score{1,7});
    xlabel(sub2, 'False Positive Rate');
    ylabel(sub2, 'True Positive Rate');
     legend(['CR   AUC=' AUC_score(5,:)], ['HE   AUC=' AUC_score(6,:)]...
        ,['SW  AUC=' AUC_score(7,:)]); 
    str={'Receiver Operating Characteristic curve for', titleName};
    suptitle(str);
    hold off
end
