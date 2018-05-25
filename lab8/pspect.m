function    [P,F]=pspect(s,Fs,Nfft,Nwin)
%   compute power spectrum from signal
%USAGE      [P,F]=pspect(s,Nfft,Nwin)
%                           s=input signal
%                           Fs=sampling frequency
%                           Nfft=FFT length.  Should be greater than or equal to Nwin
%                           Nwin=window length.
%                           P=power spectrum estimate
%                           F=frequency axis for spectrum plotting
%       Estimate is obtained by averaging periodograms of windows that overlap
%       by 50%.
if Nfft<Nwin
    error('FFT length must be greater or equal to the window length')
end
[B,F,T]=spectgr(s,Nfft,Fs,Nwin,Nwin/2);
P=mean(abs(B').^2);
if nargout==0
    plot(F,10*log10(P)),grid
    ylabel('log magnitude in dB')
    xlabel('frequency in Hz')
    title(['Power Spectrum Estimate Nwin = ',num2str(Nwin)])
end
