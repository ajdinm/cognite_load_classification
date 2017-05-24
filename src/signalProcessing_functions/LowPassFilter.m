function[Data] = LowPassFilter(CutOff, fs, Data, Order)
    wn=CutOff/(fs/2); %cut off freq, at most nyquist freq
    [a, b]=butter(Order, wn, 'low');
    Data=filter(a, b, Data);
end


