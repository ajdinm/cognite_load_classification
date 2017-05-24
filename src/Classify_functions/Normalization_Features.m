function [ FeatureNorm ] = Normalization_Features( Feature )
    MinF=min(Feature);
    MaxF=max(Feature);
    offset=0;
    for i = 1:length(Feature)
        FeatureNorm(i) = ((Feature(i)-MinF)/(MaxF-MinF))+offset;
    end
end

