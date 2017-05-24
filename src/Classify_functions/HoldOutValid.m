function [TrainIdx, TestIdx ] = HoldOutValid( Y,Part )
    YZeros=find(Y==0);
    YOnes=find(Y==1);
    
    HoldOutZeros=randperm(length(YZeros),round(Part*length(YZeros)));
    HoldOutOnes=randperm(length(YOnes),round(Part*length(YOnes)));
    TestIdx=[YZeros(HoldOutZeros); YOnes(HoldOutOnes)];
    
    TrainIdx=(1:length(Y))';
    TrainIdx(TestIdx)=[];
end

