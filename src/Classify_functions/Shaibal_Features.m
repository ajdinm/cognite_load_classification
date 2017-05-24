function [ shaibal ] = Shaibal_Features (Events, nrOfEvents)


Folder = 'C:\Users\nille\Desktop\AI Project VT 2017\Code\cognitive_load_classification\src\Classification_Evaluation\';    
addpath(genpath(Folder));

% Import but FICA
FQ = Import_HRV('HRV_Frequency_Features.csv', 2, 397);
TIME = HRVTimeFeatures('HRV_Time_Features.csv', 2, 397);
NON = HRVNonlinearFeatures('HRV_Nonlinear_Features.csv', 2, 397);
ENT = HRVEntropyFeatures('HRV_Entropy_Features.csv', 2, 397);

% 2 - 430 Full
% 2- 397 Without FICA
% 2 - 133 Hidden Exit134
% 134 - 265 Car From Right
% 266 - 397 Side Wind
% 398 - 430 FICA

% Sort
FQ = sortrows(FQ, 2); % 1 for numerical order, 2 for each event order
TIME = sortrows(TIME, 2);
NON = sortrows(NON, 2);
ENT = sortrows(ENT, 2);

% Extract features
% HRV_Entropy_Feature

% 1. Sampen = Sample Entropy
    SampenHE = table2array(ENT(1:132,5:5));
    SampenHE = Normalization_Features(SampenHE); % Normalization per subject aroun 0.25
   
        SampenCR = table2array(ENT(133:264,5:5));
        SampenCR = Normalization_Features(SampenCR);
        
            SampenSW = table2array(ENT(265:396,5:5));
            SampenSW = Normalization_Features(SampenSW);
% 2. Apen = Approximate Entropy
    ApenHE = table2array(ENT(1:132,6:6));
    ApenHE = Normalization_Features(ApenHE);
    
        ApenCR = table2array(ENT(133:264,6:6));
        ApenCR = Normalization_Features(ApenCR);
        
            ApenSW = table2array(ENT(265:396,6:6));
            ApenSW = Normalization_Features(ApenSW);
% 3. Pen = Permutation Entropy
     PenHE = table2array(ENT(1:132,7:7));
     PenHE = Normalization_Features(PenHE);
     
            PenCR = table2array(ENT(133:264,7:7));
            PenCR = Normalization_Features(PenCR);
            
                PenSW = table2array(ENT(265:396,7:7));
                PenSW = Normalization_Features(PenSW);
                
% 4. LLE = Largest Lyapunove exponent
     LLEHE = table2array(ENT(1:132,8:8));
     LLEHE = Normalization_Features(LLEHE);
     
            LLECR = table2array(ENT(133:264,8:8));
            LLECR = Normalization_Features(LLECR);
            
                LLESW = table2array(ENT(265:396,8:8));
                LLESW = Normalization_Features(LLESW);
                
% 5. Energy = Energy of the IBI signal
     EnergyHE = table2array(ENT(1:132,9:9));
     EnergyHE = Normalization_Features(EnergyHE);
     
            EnergyCR = table2array(ENT(133:264,9:9));
            EnergyCR = Normalization_Features(EnergyCR);
            
                EnergySW = table2array(ENT(265:396,9:9));
                EnergySW = Normalization_Features(EnergySW);
                
% 6. Energyen = Energy entropy of the IBI signal 
    EnergyenHE = table2array(ENT(1:132,10:10));
    EnergyenHE = Normalization_Features(EnergyenHE);
    
            EnergyenCR = table2array(ENT(133:264,10:10));
            EnergyenCR = Normalization_Features(EnergyenCR);
            
                EnergyenSW = table2array(ENT(265:396,10:10));
                EnergyenSW = Normalization_Features(EnergyenSW);

% HRV_Frequency_Feature

% 1. Vlf = Power spectral destiny of very low frequency
    VlfHE = table2array(FQ(1:132,5:5));
    VlfHE = Normalization_Features(VlfHE);
    
            VlfCR = table2array(FQ(133:264,5:5));
            VlfCR = Normalization_Features(VlfCR);
            
                VlfSW = table2array(FQ(265:396,5:5));
                VlfSW = Normalization_Features(VlfSW);
                
% 2. Lf = Power spectral destiny of low frequency
    LfHE = table2array(FQ(1:132,6:6));
    LfHE = Normalization_Features(LfHE);
    
            LfCR = table2array(FQ(133:264,6:6));
            LfCR = Normalization_Features(LfCR);
            
                LfSW = table2array(FQ(265:396,6:6));
                LfSW = Normalization_Features(LfSW);
                
% 3. Hf = Power spectral destiny of high frequency
    HfHE = table2array(FQ(1:132,7:7));
    HfHE = Normalization_Features(HfHE);
    
            HfCR = table2array(FQ(133:264,7:7));
            HfCR = Normalization_Features(HfCR);
            
                HfSW = table2array(FQ(265:396,7:7));
                HfSW = Normalization_Features(HfSW);
                
% 4. Totalpower =Power spectral destiny of total power (ultra low to high frequency range)
    TotalpowerHE = table2array(FQ(1:132,8:8));
    TotalpowerHE = Normalization_Features(TotalpowerHE);
    
            TotalpowerCR = table2array(FQ(133:264,8:8));
            TotalpowerCR = Normalization_Features(TotalpowerCR);
            
                TotalpowerSW = table2array(FQ(265:396,8:8));
                TotalpowerSW = Normalization_Features(TotalpowerSW);
                
% 5. Lfhfratio = ratio of low frequency and high frequency power
    LfhfratioHE = table2array(FQ(1:132,9:9));
    LfhfratioHE = Normalization_Features(LfhfratioHE);
    
            LfhfratioCR = table2array(FQ(133:264,9:9));
            LfhfratioCR = Normalization_Features(LfhfratioCR);
            
                LfhfratioSW = table2array(FQ(265:396,9:9));
                LfhfratioSW = Normalization_Features(LfhfratioSW);
                
% 6. Lfnu = normalised low frequency power
    LfnuHE = table2array(FQ(1:132,10:10));
    LfnuHE = Normalization_Features(LfnuHE);
    
            LfnuCR = table2array(FQ(133:264,10:10));
            LfnuCR = Normalization_Features(LfnuCR);
            
                LfnuSW = table2array(FQ(265:396,10:10));
                LfnuSW = Normalization_Features(LfnuSW);
                
% 7. Hfnu = normalised high frequency power
    HfnuHE = table2array(FQ(1:132,11:11));
    HfnuHE = Normalization_Features(HfnuHE);
    
            HfnuCR = table2array(FQ(133:264,11:11));
            HfnuCR = Normalization_Features(HfnuCR);
            
                HfnuSW = table2array(FQ(265:396,11:11));
                HfnuSW = Normalization_Features(HfnuSW);
                

% HRV_Time_Feature

% 1. Meanrr = mean of RR peak
    MeanrrHE = table2array(TIME(1:132,5:5));
    MeanrrHE = Normalization_Features(MeanrrHE);
    
            MeanrrCR = table2array(TIME(133:264,5:5));
            MeanrrCR = Normalization_Features(MeanrrCR);
            
                MeanrrSW = table2array(TIME(265:396,5:5));
                MeanrrSW = Normalization_Features(MeanrrSW);
                

% 2. Sdrr  = standard deviation of RR peak
    SdrrHE = table2array(TIME(1:132,6:6));
    SdrrHE = Normalization_Features(SdrrHE);
    
            SdrrCR = table2array(TIME(133:264,6:6));
            SdrrCR = Normalization_Features(SdrrCR);
            
                SdrrSW = table2array(TIME(265:396,6:6));
                SdrrSW = Normalization_Features(SdrrSW);
                

% 3. Meanhr = mean heart rate from ECG
    MeanhrHE = table2array(TIME(1:132,7:7));
    MeanhrHE = Normalization_Features(MeanhrHE);
    
            MeanhrCR = table2array(TIME(133:264,7:7));
            MeanhrCR = Normalization_Features(MeanhrCR);
            
                MeanhrSW = table2array(TIME(265:396,7:7));
                MeanhrSW = Normalization_Features(MeanhrSW);
                

% 4. Sdhr = standard deviation of heart rate from ECG
    SdhrHE = table2array(TIME(1:132,8:8));
    SdhrHE = Normalization_Features(SdhrHE);
    
            SdhrCR = table2array(TIME(133:264,8:8));
            SdhrCR = Normalization_Features(SdhrCR);
            
                SdhrSW = table2array(TIME(265:396,8:8));
                SdhrSW = Normalization_Features(SdhrSW);
                

% 5. Meannn  = mean of NN interval from Inter-Beat-Interval 
    MeannnHE = table2array(TIME(1:132,9:9));
    MeannnHE = Normalization_Features(MeannnHE);
    
            MeannnCR = table2array(TIME(133:264,9:9));
            MeannnCR = Normalization_Features(MeannnCR);
            
                MeannnSW = table2array(TIME(265:396,9:9));
                MeannnSW = Normalization_Features(MeannnSW);

% 6. Sdnn = standard deviation of NN interval from Inter-Beat-Interval 
    SdnnHE = table2array(TIME(1:132,10:10));
    SdnnHE = Normalization_Features(SdnnHE);
    
            SdnnCR = table2array(TIME(133:264,10:10));
            SdnnCR = Normalization_Features(SdnnCR);
            
                SdnnSW = table2array(TIME(265:396,10:10));
                SdnnSW = Normalization_Features(SdnnSW);
                

% 7. Rmssd = The square root of the mean of the sum of the squares of differences between adjacent NN intervals
    RmssdHE = table2array(TIME(1:132,11:11));
    RmssdHE = Normalization_Features(RmssdHE);
    
            RmssdCR = table2array(TIME(133:264,11:11));
            RmssdCR = Normalization_Features(RmssdCR);
            
                RmssdSW = table2array(TIME(265:396,11:11));
                RmssdSW = Normalization_Features(RmssdSW);

% 8. Sdsd = Standard deviation of differences between adjacent NN intervals
    SdsdHE = table2array(TIME(1:132,12:12));
    SdsdHE = Normalization_Features(SdsdHE);
    
            SdsdCR = table2array(TIME(133:264,12:12));
            SdsdCR = Normalization_Features(SdsdCR);
            
                SdsdSW = table2array(TIME(265:396,12:12));
                SdsdSW = Normalization_Features(SdsdSW);
                

% 9. nn50 = Number of pairs of adjacent NN intervals differing by more than 50 ms in the entire recording
    nn50HE = table2array(TIME(1:132,13:13));
    nn50HE = Normalization_Features(nn50HE);
    
            nn50CR = table2array(TIME(133:264,13:13));
            nn50CR = Normalization_Features(nn50CR);
            
                nn50SW = table2array(TIME(265:396,13:13));
                nn50SW = Normalization_Features(nn50SW);

% 10. pnn50 = NN50 count divided by the total number of all NN intervals
    pnn50HE = table2array(TIME(1:132,14:14));
    pnn50HE = Normalization_Features(pnn50HE);
    
            pnn50CR = table2array(TIME(133:264,14:14));
            pnn50CR = Normalization_Features(pnn50CR);
            
                pnn50SW = table2array(TIME(265:396,14:14));
                pnn50SW = Normalization_Features(pnn50SW);


% HRV_Nonlinear_Feature

% 1. sd1 = dispersion of the points perpendicular to the axis of line of identity (Poincare plot)
    sd1HE = table2array(NON(1:132,5:5));
    sd1HE = Normalization_Features(sd1HE);
    
            sd1CR = table2array(NON(133:264,5:5));
            sd1CR = Normalization_Features(sd1CR);
            
                sd1SW = table2array(NON(265:396,5:5));
                sd1SW = Normalization_Features(sd1SW);
                

% 2. sd2 = dispersion of the points along the axis of line of identity (Poincare plot)
    sd2HE = table2array(NON(1:132,6:6));
    sd2HE = Normalization_Features(sd2HE);
    
            sd2CR = table2array(NON(133:264,6:6));
            sd2CR = Normalization_Features(sd2CR);
            
                sd2SW = table2array(NON(265:396,6:6));
                sd2SW = Normalization_Features(sd2SW);
                

% 3. Dfaalphaall = alpha of total slop (Detrended fluctuation analysis)
    DfaalphaallHE = table2array(NON(1:132,7:7));
    DfaalphaallHE = Normalization_Features(DfaalphaallHE);
    
            DfaalphaallCR = table2array(NON(133:264,7:7));
            DfaalphaallCR = Normalization_Features(DfaalphaallCR);
            
                DfaalphaallSW = table2array(NON(265:396,7:7));
                DfaalphaallSW = Normalization_Features(DfaalphaallSW);
                

% 4. dfaalpha1 = alpha of short range scaling exponent (Detrended fluctuation analysis)
    dfaalpha1HE = table2array(NON(1:132,8:8));
    dfaalpha1HE = Normalization_Features(dfaalpha1HE);
    
            dfaalpha1CR = table2array(NON(133:264,8:8));
            dfaalpha1CR = Normalization_Features(dfaalpha1CR);
            
                dfaalpha1SW = table2array(NON(265:396,8:8));
                dfaalpha1SW = Normalization_Features(dfaalpha1SW);
                

% 5. dfaalpha2 = alpha of long range scaling exponent (Detrended fluctuation analysis)
    dfaalpha2HE = table2array(NON(1:132,9:9));
    dfaalpha2HE = Normalization_Features(dfaalpha2HE);
    
            dfaalpha2CR = table2array(NON(133:264,9:9));
            dfaalpha2CR = Normalization_Features(dfaalpha2CR);
            
                dfaalpha2SW = table2array(NON(265:396,9:9));
                dfaalpha2SW = Normalization_Features(dfaalpha2SW);
                

Table_CR=[ApenCR; dfaalpha1CR; dfaalpha2CR; DfaalphaallCR; EnergyCR; EnergyenCR; HfCR; HfnuCR; LfCR...
    ;LfhfratioCR; LfnuCR; LLECR; MeanhrCR; MeannnCR; MeanrrCR; nn50CR; PenCR; pnn50CR; RmssdCR...
    ;SampenCR; sd1CR; sd2CR; SdhrCR; SdnnCR; SdrrCR; SdsdCR; TotalpowerCR; VlfCR];
Table_CR=Table_CR';
Table_SW=[ApenSW; dfaalpha1SW; dfaalpha2SW; DfaalphaallSW; EnergySW; EnergyenSW; HfSW; HfnuSW; LfSW...
    ;LfhfratioSW; LfnuSW; LLESW; MeanhrSW; MeannnSW; MeanrrSW; nn50SW; PenSW; pnn50SW; RmssdSW...
    ;SampenSW; sd1SW; sd2SW; SdhrSW; SdnnSW; SdrrSW; SdsdSW; TotalpowerSW; VlfSW];
Table_SW=Table_SW';
Table_HE=[ApenHE; dfaalpha1HE; dfaalpha2HE; DfaalphaallHE; EnergyHE; EnergyenHE; HfHE; HfnuHE; LfHE...
    ;LfhfratioHE; LfnuHE; LLEHE; MeanhrHE; MeannnHE; MeanrrHE; nn50HE; PenHE; pnn50HE; RmssdHE...
    ;SampenHE; sd1HE; sd2HE; SdhrHE; SdnnHE; SdrrHE; SdsdHE; TotalpowerHE; VlfHE];
Table_HE=Table_HE';


% Remove the 13:th subject, actaully the 11:th element  - 41 to 45
 
All_CR = [Table_CR(1:41,:);Table_CR(46:132,:)]; % 32 subjects without nr13

All_SW = [Table_SW(1:41,:);Table_SW(46:132,:)];

All_HE = [Table_HE(1:41,:);Table_HE(46:132,:)];

% All_CR = [Table_CR(1:41,:);Table_CR(42:132,:)]; % 33 subject with nr13
% 
% All_SW = [Table_SW(1:41,:);Table_SW(42:132,:)];
% 
% All_HE = [Table_HE(1:41,:);Table_HE(42:132,:)];

shaibal=[];
for n=1:nrOfEvents

    if Events(n,:) == 'CR'
        shaibal = [shaibal;All_CR(:,:)];
    end
    if Events(n,:) == 'HE'
        shaibal = [shaibal;All_HE(:,:)];
    end
    if Events(n,:) == 'SW'
        shaibal = [shaibal;All_SW(:,:)];
    end
    n=n+1;
end

end