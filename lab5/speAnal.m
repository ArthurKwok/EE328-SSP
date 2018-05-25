function [  ] = speAnal( file_name, start, nsamples )
%SPEANAL answer of lab5q3
% file_name: string of the file name
% start: the staring sample of the signal in file
% length: length of signal in sample
signal = audioread(file_name);
signal = signal(start:start+nsamples-1);
subplot(2,2,1);plot(signal);title('windowed signal');ylim([-1,1]);
signal = signal.*hamming(nsamples);% use hamming window 

spectrum = 20*log(abs(fft(signal)));
cepstrum = myCepstrum(signal,'R');
% do liftering by a 25% low-pass lifter, then turn back to log spectrum,
% then times 10 to dB scale
spectrum_liftered = real(20*(fft(cepstrum(1024:1024+100),2048)));

[spectrum,x1] = fftshift(spectrum);
subplot(2,2,2);stem(x1, spectrum,'Marker','none');title('spectrum (dB)');xlim([-pi/2,pi/2]);
subplot(2,2,3);stem(cepstrum,'Marker','none');title('real cepstrum');axis([0,2048,-1,1]);
[spectrum_liftered,x2] = fftshift(spectrum_liftered);
subplot(2,2,4);stem(x2,spectrum_liftered,'Marker','none');title('low pass liftered spectrum (dB)');xlim([-pi/2,pi/2]);

end

function [outSpec, outx] = fftshift(inSpec)
% shift the fft result and generate the modified x value
inSpec = inSpec';
L = length(inSpec);
outSpec = [inSpec(round(L/2):L), inSpec(1:round(L/2))];
outx = (-L/2:L/2)*pi/L;
    
end