function [X1, NoFeatures, NoVehFeat, NoPhysFeat] = Feat_Selection(XTrain, Y, k, nrOfFeat,CritInclude,X)

[inmodel,history]=sequentialfs(@OptFeatures,XTrain,Y,'cv',k,'direction','forward','nfeatures',nrOfFeat);
threshold=max(history.Crit)-max(history.Crit)*(1-CritInclude);
[~,indx]=find(inmodel==1);
SelectedFeatures=indx(history.Crit > threshold);
X1=X(:,SelectedFeatures(:,:));
NoFeatures=length(SelectedFeatures);

Veh_Feat=[3,4,6,7,8,9,10,11];
NoVehFeat=sum(ismember(Veh_Feat, SelectedFeatures));

NoPhysFeat=NoFeatures - NoVehFeat;

end