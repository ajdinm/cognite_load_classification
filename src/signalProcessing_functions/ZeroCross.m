function [ numZeroCross] = ZeroCross( idxStart, idxEnd, Data)
    zcd=dsp.ZeroCrossingDetector;   
    numZeroCross=step(zcd, Data(idxStart: idxEnd));
end


    

