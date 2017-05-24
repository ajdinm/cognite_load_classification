function[Data] = HighPassFilter(CutOff, fs, Data, Order)
    wn = CutOff/(fs/2); %cut off freq, at most nyquist freq
    [a, b]=butter(Order, wn,'high'); 
    Data=filter(a, b, Data);
end
 
