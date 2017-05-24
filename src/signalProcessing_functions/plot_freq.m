function [] = plot_freq(fs, data)
   %plotting frequency contet of the signal
   %fs = sampling speed (Hz)
   %data = data to plot
   N=length(data);
   fax_bins=[0:N-1];
   fax_Hz=fax_bins*fs/N;
   N_2=ceil(N/2);
   FreqData = abs(fft(data));
   figure
   plot(fax_Hz(1:N_2),FreqData(1:N_2))
   xlabel('Frequency (Hz)');
   ylabel('Magnitude');
   axis tight;
end